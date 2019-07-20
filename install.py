#!/usr/bin/env python3
from argparse import ArgumentParser
import os
from collections import defaultdict
import sys
import shutil

HOME = os.path.expanduser('~')


def main():
    global HOME
    parser = ArgumentParser()
    parser.add_argument('--home',
            type=str,
            default=HOME
    )
    parser.add_argument('--dot-dir-root', '-d',
            type=str,
            default=os.path.join(HOME, '.dotfiles')
    )
    parser.add_argument('--dry', '-n',
            default=False,
            action='store_true'
    )
    parser.add_argument('--copy', '--do-not-symlink',
            default=False,
            action='store_true'
    )
    g = parser.add_mutually_exclusive_group()
    g.add_argument('--remove-dead', '--clean',
            default=False,
            action='store_true'
    )
    g.add_argument('--skip-symlink-check', '--ssc',
            default=False,
            action='store_true'
    )
    args = parser.parse_args()

    HOME = args.home

    links = []

    dotfile_map = discover_dotfiles(args.dot_dir_root)
    dotfiles = resolve_duplicates(args.copy, dotfile_map)
    created_files = apply_dotfiles(args.dry, args.copy, dotfiles)

    if not args.skip_symlink_check:
        remove_dead_links(args.remove_dead, created_files)


def discover_dotfiles(dot_dir_root):
    paths = defaultdict(list)

    for dirpath, dirnames, filenames in os.walk(dot_dir_root):
        relative_dir = dirpath.replace(dot_dir_root, "")

        if 'home' not in relative_dir:
            continue

        home_dir = relative_dir[relative_dir.index('home') + 5:]

        for fname in filenames:
            abspath = os.path.join(dirpath, fname)
            relpath = os.path.join(home_dir, fname)
            paths[relpath].append(abspath)

    return paths


def resolve_duplicates(copy, dotfile_map):
    combinable = [
        Combinable('.vimrc', comment_char='"'),
        Combinable('.config/nvim/init.vim', comment_char='"'),
        Combinable('.config/nvim/ginit.vim', comment_char='"'),
        Combinable('.bashrc'),
        Combinable('.zshrc'),
        Combinable('.profile'),
    ]

    unhandled = []
    dotfiles = []
    for relpath, fullpaths in dotfile_map.items():
        if len(fullpaths) == 1:
            df = Dotfile(fullpaths[0], relpath)
            dotfiles.append(df)
        else:
            for c in combinable:
                if c.matches(relpath):
                    c.extend(fullpaths)
                    if c not in dotfiles:
                        dotfiles.append(c)
                    break
            else:
                unhandled.append((relpath, fullpaths))

    if any(unhandled):
        print('error: ')
        print('error: Found matching files, but do not know how to combine')

        for relpath, fullpaths in unhandled:
            print('error: ')
            print(f'error: dotfile = {relpath}')
            for fp in fullpaths:
                print(f'error: full path = {fp}')

        print('error: ')
        sys.exit(-1)

    return dotfiles


def apply_dotfiles(dry, copy, dotfiles):
    created_files = []
    for df in dotfiles:
        created_files.append(df.link(dry, copy))
    return created_files


def mkdirs(dry, path):
    if not os.path.exists(path):
        print(f'making directory {path}')
        try:
            os.makedirs(path)
        except:
            pass


def remove_dead_links(clean, created_files):
    created_files = set(created_files)

    def recurse(dirpath):
        for path in os.listdir(dirpath):
            full_path = os.path.join(dirpath, path)

            if os.path.isdir(full_path) and path != '.git':
                recurse(full_path)
            elif full_path in created_files:
                continue
            elif os.path.lexists(full_path) != os.path.exists(full_path):
                print(f'symlink target missing for {full_path}')

                if clean:
                    print(f'    rm {full_path}')
                    os.remove(full_path)
            else:
                try:
                    with open(full_path, 'r') as stream:
                        header = [stream.readline() for _ in range(6)]
                except:
                    # there are not that many lines... or no lines at all
                    continue

                if 'This file was automatically generated' in header:
                    if 'You probably should not edit it' in header:
                        print(f'file contains header but was not created now {full_path}')

                        if clean:
                            print(f'    rm {full_path}')
                            os.remove(full_path)

    recurse(HOME)


class Dotfile(object):

    def __init__(self, abspath, refpath):
        self.abspath = abspath
        self.refpath = refpath
        self.destpath = os.path.join(HOME, refpath)

    def link(self, dry, copy):
        mkdirs(dry, os.path.dirname(self.destpath))

        if not dry and os.path.lexists(self.destpath):
            os.remove(self.destpath)

        if copy:
            print(f'creating copy {self.destpath} <- {self.abspath}')
            if not dry:
                shutil.copy(self.abspath, self.destpath)
        else:
            print(f'creating symlink {self.destpath} <- {self.abspath}')
            if not dry:
                os.symlink(self.abspath, self.destpath)

        return self.destpath


class Combinable(object):

    def __init__(self, *refpaths, comment_char='#'):
        self.refpath = refpaths[0]
        self.destpath = os.path.join(HOME, self.refpath)
        self.refpaths = refpaths
        self.dotfiles = []
        self.comment_char = comment_char

    def matches(self, refpath):
        return refpath in self.refpaths

    def extend(self, dotfiles):
        self.dotfiles.extend(dotfiles)

    def _comment(self, string):
        return string.replace('#', self.comment_char)

    def _write_banner(self, conf_file):
        conf_file.write('\n')
        conf_file.write(self._comment('#############################################\n'))
        conf_file.write(self._comment('#  This file was automatically generated.   #\n'))
        conf_file.write(self._comment('# You probably should not edit it directly. #\n'))
        conf_file.write(self._comment('#############################################\n'))
        conf_file.write('\n')

    def link(self, dry, copy):
        print(f'creating == {self.destpath} == with sources')

        try:
            conf_file = None

            if not dry:
                if os.path.exists(self.destpath):
                    os.remove(self.destpath)
                conf_file = open(self.destpath, 'w')
                self._write_banner(conf_file)

            for df in self.dotfiles:

                if copy:
                    print(f'    read {df}')

                    if not dry:
                        with open(df, 'r') as source_stream:
                            conf_file.write(self._comment(f'\n## ((( BEGIN {df}\n'))
                            conf_file.write(source_stream.read())
                            conf_file.write(self._comment(f'\n## ))) END {df}\n'))
                else:
                    print(f'    source {df}')

                    if not dry:
                        conf_file.write(f'source {df}\n')

        finally:
            if conf_file is not None:
                conf_file.close()

        return self.destpath


if __name__ == '__main__':
    main()
