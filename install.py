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
    args = parser.parse_args()

    HOME = args.home

    links = []

    dotfile_map = discover_dotfiles(args.dot_dir_root)
    dotfiles = resolve_duplicates(args.copy, dotfile_map)
    apply_dotfiles(args.dry, args.copy, dotfiles)


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
    for df in dotfiles:
        df.link(dry, copy)


def mkdirs(dry, path):
    if not os.path.exists(path):
        print(f'making directory {path}')
        os.makedirs(path, exists_ok=True)


class Dotfile(object):

    def __init__(self, abspath, refpath):
        self.abspath = abspath
        self.refpath = refpath
        self.destpath = os.path.join(HOME, refpath)

    def link(self, dry, copy):
        mkdirs(dry, os.path.dirname(self.destpath))

        if not dry and os.path.exists(self.destpath):
            os.remove(self.destpath)

        if copy:
            print(f'creating copy {self.destpath} <- {self.abspath}')
            if not dry:
                shutil.copy(self.abspath, self.destpath)
        else:
            print(f'creating symlink {self.destpath} <- {self.abspath}')
            if not dry:
                os.symlink(self.abspath, self.destpath)


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


if __name__ == '__main__':
    main()
