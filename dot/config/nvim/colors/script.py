#!/usr/bin/env python3
import json
import numpy as np
import urllib.request
import os

# source $VIMRUNTIME/syntax/hitest.vim

if not os.path.exists('data.json'):
    urllib.request.urlretrieve(
            'https://jonasjacek.github.io/colors/data.json',
            'data.json'
    )

term_colors = np.array(
        [
            (c['rgb']['r'], c['rgb']['g'], c['rgb']['b'])
            for c in json.loads(open('data.json', 'r').read())
        ]
)

class Color(object):

    def __init__(self, rgb, name):
        self.rgb = rgb
        self.name = name
        index = np.argmin(abs(term_colors - rgb).sum(axis=1))
        print(f"best term color for {self.name} {rgb}: {index} {term_colors[index]}")
        self.ansi = index
        self.ansi_rgb = term_colors[index]

    def get_rgb(self):
        return ''.join('{:02x}'.format(n) for n in self.rgb)


# http://colorizer.org/
compliments = (
        Color((  0,  74,   0), "green"),                    # 0
        Color((178, 255, 148), "bright_green"),             # 1
        Color((  0,  27,   0), "dark_green"),               # 2
        Color(( 85, 207, 137), "bright_green2"),              # 3
        Color((207,  85,  95), "red"),                      # 4
        Color((207, 136,  85), "orange"),                   # 5
        Color((207, 197,  85), "yellow"),                   # 6
        Color((156, 207,  85), "yellow_green"),             # 8
        Color(( 95, 207,  85), "light_green"),              # 8
        Color(( 85, 207, 136), "seafoam_green"),            # 9
        Color(( 85, 207, 197), "tealish"),                  # 10
        Color(( 85, 156, 207), "blue_purple"),              # 11
        Color(( 85,  95, 207), "purple_blue"),              # 12
        Color((136,  85, 207), "purple"),                   # 13
        Color((197,  85, 207), "magenta"),                  # 14
        Color((207,  85, 156), "reddish_pink"),             # 15

        Color((255, 255, 255), "white"),                    # 16
        Color(( 35, 137,  16), "mid_green"),                # 17
)

the_colors = {i: c for i, c in enumerate(compliments)}
the_colors.update({c.name: c for c in compliments})

def hi(names, *, fg=None, bg=None, style=None):
    if isinstance(names, str):
        names = [names]

    ctermfg = (f"ctermfg='.s:{fg.name}.ansi.'" if fg else '').ljust(35)
    ctermbg = (f"ctermbg='.s:{bg.name}.ansi.'" if bg else '').ljust(35)
    guifg = (f"guifg='.s:{fg.name}.rgb.'" if fg else '').ljust(35)
    guibg = (f"guibg='.s:{bg.name}.rgb.'" if bg else '').ljust(35)
    style = f'cterm={style} gui={style}' if style is not None else ''

    lines = []
    for name in names:
        lines.append(f"exec 'hi {name.ljust(15)} {ctermfg} {ctermbg} {guifg} {guibg} {style}'\n")

    return ''.join(lines).replace('dark_green', 'background').replace('white', 'foreground').replace('bright_green', 'highlight')

with open('happy.vim', 'w') as f:
    f.write('''
hi clear

if has('termguicolors')
    set termguicolors
endif

if exists("syntax_on")
  syntax reset
endif

" syn match happyPunctuation /[\[(){}\]+*,=_\-!@""#$%^&*<>?\\/]/

let colors_name = "happy"

" the colors
''')
    for k, color in the_colors.items():
        if isinstance(k, str):
            f.write(f'let s:{color.name} = {{\'ansi\': {color.ansi}, \'rgb\': \'#{color.get_rgb()}\'}}\n')

    f.write('''

if &background == 'dark'
    let s:foreground=s:white
    let s:background=s:dark_green
    let s:highlight=s:bright_green
else
    let s:foreground=s:dark_green
    let s:background=s:white
    let s:highlight=s:yellow_green
endif


" highlighting
''')

    f.write(hi('Normal', fg=the_colors['white'], bg=the_colors['dark_green']))
    f.write(hi('ColorColumn', bg=the_colors['green']))

    f.write(hi('Cursor', bg=the_colors['bright_green']))
    f.write(hi('CursorLineNr', fg=the_colors['bright_green'], bg=the_colors['dark_green']))
    f.write(hi('CursorLine', fg=the_colors['bright_green'], bg=the_colors['dark_green']))
    f.write(hi('LineNr', fg=the_colors['mid_green'], bg=the_colors['dark_green']))

    f.write(hi('NonText', fg=the_colors['green'], bg=the_colors['dark_green']))
    f.write(hi('Conceal', fg=the_colors['green'], bg=the_colors['dark_green']))
    f.write(hi('Ignore', fg=the_colors['green'], bg=the_colors['dark_green']))
    f.write(hi('SignColumn', fg=the_colors['bright_green'], bg=the_colors['dark_green']))
    f.write(hi('VertSplit', fg=the_colors['green'], bg=the_colors['dark_green']))
    f.write(hi('MatchParen', fg=the_colors['green'], bg=the_colors['bright_green']))
    f.write(hi('Search', fg=the_colors['dark_green'], bg=the_colors['reddish_pink']))
    f.write(hi('IncSearch', bg=the_colors['dark_green'], fg=the_colors['reddish_pink'], style='underline'))

    f.write(hi('TabLine', fg=the_colors['green'], bg=the_colors['dark_green']))
    f.write(hi('TabLineFill', fg=the_colors['green'], bg=the_colors['dark_green']))
    f.write(hi('TabLineSel', fg=the_colors['bright_green'], bg=the_colors['dark_green']))

    f.write(hi('Pmenu', fg=the_colors['bright_green'], bg=the_colors['dark_green']))
    f.write(hi('PmenuSel', fg=the_colors['magenta'], bg=the_colors['dark_green'], style='bold'))
    f.write(hi('PmenuSbar', fg=the_colors['bright_green'], bg=the_colors['dark_green']))      # could look crappy
    f.write(hi('PmenuThumb', fg=the_colors['magenta'], bg=the_colors['dark_green']))    # could look crappy


    # "" Syntax highlighting
    f.write(hi('Comment', fg=the_colors['mid_green'], bg=the_colors['dark_green'], style='italic'))
    f.write(hi('SpecialComment', fg=the_colors['bright_green'], bg=the_colors['dark_green'], style='bold'))
    f.write(hi('Todo', fg=the_colors['green'], bg=the_colors['light_green'])) # TODO:
    f.write(hi('Constant', fg=the_colors['orange'], bg=the_colors['dark_green']))
    f.write(hi('Character', fg=the_colors['magenta'], bg=the_colors['dark_green']))
    f.write(hi('Delimeter', fg=the_colors['bright_green'], bg=the_colors['green']))
    # f.write(hi('Number', fg=the_colors['yellow'], bg=the_colors['dark_green']))
    # f.write(hi('String', fg=the_colors['yellow'], bg=the_colors['dark_green']))
    f.write(hi('NvimParenthesis', fg=the_colors['bright_green'], bg=the_colors['green']))
    f.write(hi('NvimComma', fg=the_colors['bright_green'], bg=the_colors['green']))
    f.write(hi('NvimColon', fg=the_colors['bright_green'], bg=the_colors['green']))
    f.write(hi('Conditional', fg=the_colors['magenta'], bg=the_colors['dark_green']))
    f.write(hi('Label', fg=the_colors['magenta'], bg=the_colors['dark_green']))
    f.write(hi('Operator', fg=the_colors['red'], bg=the_colors['dark_green']))
    f.write(hi('Special', fg=the_colors['white'], bg=the_colors['dark_green']))
    f.write(hi('PreProc', fg=the_colors['orange'], bg=the_colors['dark_green'], style='bold'))
    f.write(hi('Statement', fg=the_colors['red'], bg=the_colors['dark_green'], style='bold'))
    f.write(hi('Identifier', fg=the_colors['reddish_pink'], bg=the_colors['dark_green'], style='bold'))
    f.write(hi('StorageClass', fg=the_colors['reddish_pink'], bg=the_colors['dark_green'], style='bold'))
    f.write(hi('Type', fg=the_colors['yellow'], bg=the_colors['dark_green'], style='bold'))
    f.write(hi('Error', fg=the_colors['white'], bg=the_colors['red']))
    f.write(hi('ErrorMsg', fg=the_colors['white'], bg=the_colors['red']))
    f.write(hi('WarningMsg', fg=the_colors['white'], bg=the_colors['orange']))

    f.write(hi('Title', fg=the_colors['magenta'], bg=the_colors['dark_green'], style='bold'))
    f.write(hi('markdownIdDeclaration', fg=the_colors['tealish'], bg=the_colors['dark_green'], style='bold'))
    f.write(hi('markdownUrl', fg=the_colors['tealish'], bg=the_colors['dark_green'], style='bold'))

    f.write(hi('graphqlStructure', fg=the_colors['red'], bg=the_colors['dark_green'], style='bold'))
    f.write(hi('graphqlType', fg=the_colors['yellow'], bg=the_colors['dark_green'], style='bold'))

    f.write(hi('yamlKey', fg=the_colors['red'], bg=the_colors['dark_green'], style='bold'))
    f.write(hi('yamlBlockMappingKey', fg=the_colors['red'], bg=the_colors['dark_green'], style='bold'))

    f.write(hi('Directory', fg=the_colors['magenta'], bg=the_colors['dark_green']))

    f.write(hi(['DiffAdd', 'diffAdded'], fg=the_colors['bright_green'], bg=the_colors['dark_green']))
    f.write(hi(['DiffDelete', 'diffRemoved'], fg=the_colors['red'], bg=the_colors['dark_green']))
    f.write(hi(['DiffChange'], fg=None, bg=the_colors['green']))
    f.write(hi(['DiffText'], fg=the_colors['tealish'], bg=the_colors['dark_green']))

    f.write(hi('diffFile', fg=the_colors['bright_green'], bg=the_colors['dark_green']))
    f.write(hi('gitcommitDiff', fg=the_colors['reddish_pink'], bg=the_colors['dark_green']))
    f.write(hi('diffIndexLine', fg=the_colors['yellow'], bg=the_colors['dark_green']))
    f.write(hi('diffLine', fg=the_colors['magenta'], bg=the_colors['dark_green']))

    f.write(hi('RedrawDebugNormal', fg=the_colors['dark_green'], bg=the_colors['bright_green']))
    f.write(hi('RedrawDebugClear', fg=the_colors['dark_green'], bg=the_colors['yellow']))
    f.write(hi('RedrawDebugComposed', fg=the_colors['dark_green'], bg=the_colors['red']))
    f.write(hi('RedrawDebugRecompose', fg=the_colors['dark_green'], bg=the_colors['bright_green']))

    f.write(hi('ExtraWhitespace', fg=the_colors['magenta'], bg=the_colors['dark_green'], style='underline'))

    f.write(hi('NvimInternalError', fg=the_colors['dark_green'], bg=the_colors['red']))

#     f.write(hi('airline_a', fg=the_colors['bright_green'], bg=the_colors['dark_green']))
#     f.write(hi('airline_b', fg=the_colors['bright_green'], bg=the_colors['dark_green']))
#     f.write(hi('airline_c', fg=the_colors['bright_green'], bg=the_colors['dark_green']))
#     f.write(hi('airline_x', fg=the_colors['bright_green'], bg=the_colors['dark_green']))
#     f.write(hi('airline_y', fg=the_colors['bright_green'], bg=the_colors['dark_green']))
#     f.write(hi('airline_z', fg=the_colors['bright_green'], bg=the_colors['dark_green']))
