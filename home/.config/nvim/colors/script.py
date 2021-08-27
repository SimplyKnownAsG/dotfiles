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
        Color((  0,  74,   0), "background"),               # 0
        Color((178, 255, 148), "bright green"),             # 1
        Color((  0,  27,   0), "0,-50,25"),                 # 2
        Color(( 85, 207, 137), "75,-50,25"),                # 3
        Color((207,  85,  95), "red"),                      # 4
        Color((207, 136,  85), "orange"),                   # 5
        Color((207, 197,  85), "yellow"),                   # 6
        Color((156, 207,  85), "yellow green"),             # 8
        Color(( 95, 207,  85), "light green"),              # 8
        Color(( 85, 207, 136), "seafoam green"),            # 9
        Color(( 85, 207, 197), "tealish"),                  # 10
        Color(( 85, 156, 207), "blue purple"),              # 11
        Color(( 85,  95, 207), "purple blue"),              # 12
        Color((136,  85, 207), "purple"),                   # 13
        Color((197,  85, 207), "magenta"),                  # 14
        Color((207,  85, 156), "reddish pink"),             # 15

        Color((255, 255, 255), "white"),                    # 16
        Color(( 35, 137,  16), "50, -50, 50"),              # 17
)

def hi(names, *, fg=None, bg=None, style=None):
    if isinstance(names, str):
        names = [names]

    ctermfg = (f'ctermfg={fg.ansi}' if fg else '').ljust(15)
    ctermbg = (f'ctermbg={bg.ansi}' if bg else '').ljust(15)
    guifg = (f'guifg=#{fg.get_rgb()}' if fg else '').ljust(15)
    guibg = (f'guibg=#{bg.get_rgb()}' if bg else '').ljust(15)
    style = f'cterm={style} gui={style}' if style is not None else ''

    lines = []
    for name in names:
        lines.append(f"hi {name.ljust(15)} {ctermfg} {ctermbg} {guifg} {guibg} {style}\n")

    return ''.join(lines)

with open('happy.vim', 'w') as f:
    f.write('''set background=dark
hi clear

if has('termguicolors')
    set termguicolors
endif

if exists("syntax_on")
  syntax reset
endif

" syn match happyPunctuation /[\[(){}\]+*,=_\-!@""#$%^&*<>?\\/]/

let colors_name = "happy"
" General colors
''')
    f.write(hi('Normal', fg=compliments[16], bg=compliments[2]))
    f.write(hi('ColorColumn', bg=compliments[0]))

    f.write(hi('Cursor', bg=compliments[3]))
    f.write(hi('CursorLineNr', fg=compliments[3], bg=compliments[2]))
    f.write(hi('CursorLine', fg=compliments[1], bg=compliments[2]))
    f.write(hi('LineNr', fg=compliments[17], bg=compliments[2]))

    f.write(hi('NonText', fg=compliments[0], bg=compliments[2]))
    f.write(hi('Conceal', fg=compliments[0], bg=compliments[2]))
    f.write(hi('Ignore', fg=compliments[0], bg=compliments[2]))
    f.write(hi('SignColumn', fg=compliments[1], bg=compliments[2]))
    f.write(hi('VertSplit', fg=compliments[0], bg=compliments[2]))
    f.write(hi('MatchParen', fg=compliments[0], bg=compliments[1]))
    f.write(hi('Search', fg=compliments[2], bg=compliments[15]))
    f.write(hi('IncSearch', bg=compliments[2], fg=compliments[15], style='underline'))

    f.write(hi('TabLine', fg=compliments[0], bg=compliments[2]))
    f.write(hi('TabLineFill', fg=compliments[0], bg=compliments[2]))
    f.write(hi('TabLineSel', fg=compliments[3], bg=compliments[2]))

    f.write(hi('Pmenu', fg=compliments[3], bg=compliments[0]))
    f.write(hi('PmenuSel', fg=compliments[16], bg=compliments[0]))
    f.write(hi('PmenuSbar', fg=compliments[3], bg=compliments[0]))      # could look crappy
    f.write(hi('PmenuThumb', fg=compliments[14], bg=compliments[0]))    # could look crappy


    # "" Syntax highlighting
    f.write(hi('Comment', fg=compliments[17], bg=compliments[2], style='italic'))
    f.write(hi('SpecialComment', fg=compliments[1], bg=compliments[2], style='italic'))
    f.write(hi('Todo', fg=compliments[0], bg=compliments[8])) # TODO:
    f.write(hi('Constant', fg=compliments[5], bg=compliments[2]))
    f.write(hi('Character', fg=compliments[14], bg=compliments[2]))
    f.write(hi('Delimeter', fg=compliments[1], bg=compliments[0]))
    # f.write(hi('Number', fg=compliments[6], bg=compliments[2]))
    # f.write(hi('String', fg=compliments[6], bg=compliments[2]))
    f.write(hi('NvimParenthesis', fg=compliments[1], bg=compliments[0]))
    f.write(hi('NvimComma', fg=compliments[1], bg=compliments[0]))
    f.write(hi('NvimColon', fg=compliments[1], bg=compliments[0]))
    f.write(hi('Conditional', fg=compliments[14], bg=compliments[2]))
    f.write(hi('Label', fg=compliments[14], bg=compliments[2]))
    f.write(hi('Operator', fg=compliments[4], bg=compliments[2]))
    f.write(hi('Special', fg=compliments[16], bg=compliments[2]))
    f.write(hi('PreProc', fg=compliments[5], bg=compliments[2], style='bold'))
    f.write(hi('Statement', fg=compliments[4], bg=compliments[2], style='bold'))
    f.write(hi('Identifier', fg=compliments[15], bg=compliments[2], style='bold'))
    f.write(hi('StorageClass', fg=compliments[15], bg=compliments[2], style='bold'))
    f.write(hi('Type', fg=compliments[6], bg=compliments[2], style='bold'))
    f.write(hi('Error', fg=compliments[16], bg=compliments[4]))
    f.write(hi('ErrorMsg', fg=compliments[16], bg=compliments[4]))
    f.write(hi('WarningMsg', fg=compliments[16], bg=compliments[5]))

    f.write(hi('Title', fg=compliments[14], bg=compliments[2], style='bold'))
    f.write(hi('markdownIdDeclaration', fg=compliments[10], bg=compliments[2], style='bold'))
    f.write(hi('markdownUrl', fg=compliments[10], bg=compliments[2], style='bold'))

    f.write(hi('graphqlStructure', fg=compliments[4], bg=compliments[2], style='bold'))
    f.write(hi('graphqlType', fg=compliments[6], bg=compliments[2], style='bold'))

    f.write(hi('yamlKey', fg=compliments[4], bg=compliments[2], style='bold'))
    f.write(hi('yamlBlockMappingKey', fg=compliments[4], bg=compliments[2], style='bold'))

    f.write(hi('Directory', fg=compliments[14], bg=compliments[2]))

    f.write(hi(['DiffAdd', 'diffAdded'], fg=compliments[3], bg=compliments[2]))
    f.write(hi(['DiffDelete', 'diffRemoved'], fg=compliments[4], bg=compliments[2]))
    f.write(hi(['DiffChange'], fg=None, bg=compliments[0]))
    f.write(hi(['DiffText'], fg=compliments[10], bg=compliments[2]))

    f.write(hi('diffFile', fg=compliments[1], bg=compliments[2]))
    f.write(hi('gitcommitDiff', fg=compliments[15], bg=compliments[2]))
    f.write(hi('diffIndexLine', fg=compliments[6], bg=compliments[2]))
    f.write(hi('diffLine', fg=compliments[14], bg=compliments[2]))

    f.write(hi('RedrawDebugNormal', fg=compliments[2], bg=compliments[1]))
    f.write(hi('RedrawDebugClear', fg=compliments[2], bg=compliments[6]))
    f.write(hi('RedrawDebugComposed', fg=compliments[2], bg=compliments[4]))
    f.write(hi('RedrawDebugRecompose', fg=compliments[2], bg=compliments[1]))

    f.write(hi('ExtraWhitespace', fg=compliments[14], bg=compliments[0], style='underline'))

    f.write(hi('NvimInternalError', fg=compliments[2], bg=compliments[4]))

#     f.write(hi('airline_a', fg=compliments[1], bg=compliments[2]))
#     f.write(hi('airline_b', fg=compliments[1], bg=compliments[2]))
#     f.write(hi('airline_c', fg=compliments[1], bg=compliments[2]))
#     f.write(hi('airline_x', fg=compliments[1], bg=compliments[2]))
#     f.write(hi('airline_y', fg=compliments[1], bg=compliments[2]))
#     f.write(hi('airline_z', fg=compliments[1], bg=compliments[2]))
