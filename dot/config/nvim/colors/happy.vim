
hi clear

if has('termguicolors')
    set termguicolors
endif

if exists("syntax_on")
  syntax reset
endif

" syn match happyPunctuation /[\[(){}\]+*,=_\-!@""#$%^&*<>?\/]/

let colors_name = "happy"

" the colors
let s:green = {'ansi': 22, 'rgb': '#004a00'}
let s:bright_green = {'ansi': 156, 'rgb': '#b2ff94'}
let s:dark_green = {'ansi': 0, 'rgb': '#001b00'}
let s:bright_green2 = {'ansi': 78, 'rgb': '#55cf89'}
let s:red = {'ansi': 167, 'rgb': '#cf555f'}
let s:orange = {'ansi': 173, 'rgb': '#cf8855'}
let s:yellow = {'ansi': 185, 'rgb': '#cfc555'}
let s:yellow_green = {'ansi': 149, 'rgb': '#9ccf55'}
let s:light_green = {'ansi': 77, 'rgb': '#5fcf55'}
let s:seafoam_green = {'ansi': 78, 'rgb': '#55cf88'}
let s:tealish = {'ansi': 80, 'rgb': '#55cfc5'}
let s:blue_purple = {'ansi': 74, 'rgb': '#559ccf'}
let s:purple_blue = {'ansi': 62, 'rgb': '#555fcf'}
let s:purple = {'ansi': 98, 'rgb': '#8855cf'}
let s:magenta = {'ansi': 170, 'rgb': '#c555cf'}
let s:reddish_pink = {'ansi': 169, 'rgb': '#cf559c'}
let s:white = {'ansi': 15, 'rgb': '#ffffff'}
let s:mid_green = {'ansi': 28, 'rgb': '#238910'}


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
exec 'hi SpelunkerSpellBad ctermbg=224 gui=undercurl guisp=Red'
exec 'hi Normal          ctermfg='.s:foreground.ansi.'            ctermbg='.s:background.ansi.'       guifg='.s:foreground.rgb.'               guibg='.s:background.rgb.'          '
exec 'hi ColorColumn                                         ctermbg='.s:green.ansi.'                                                guibg='.s:green.rgb.'               '
exec 'hi Cursor                                              ctermbg='.s:highlight.ansi.'                                         guibg='.s:highlight.rgb.'        '
exec 'hi CursorLineNr    ctermfg='.s:highlight.ansi.'     ctermbg='.s:background.ansi.'       guifg='.s:highlight.rgb.'        guibg='.s:background.rgb.'          '
exec 'hi CursorLine      ctermfg='.s:highlight.ansi.'     ctermbg='.s:background.ansi.'       guifg='.s:highlight.rgb.'        guibg='.s:background.rgb.'          '
exec 'hi LineNr          ctermfg='.s:mid_green.ansi.'        ctermbg='.s:background.ansi.'       guifg='.s:mid_green.rgb.'           guibg='.s:background.rgb.'          '
exec 'hi NonText         ctermfg='.s:green.ansi.'            ctermbg='.s:background.ansi.'       guifg='.s:green.rgb.'               guibg='.s:background.rgb.'          '
exec 'hi Conceal         ctermfg='.s:green.ansi.'            ctermbg='.s:background.ansi.'       guifg='.s:green.rgb.'               guibg='.s:background.rgb.'          '
exec 'hi Ignore          ctermfg='.s:green.ansi.'            ctermbg='.s:background.ansi.'       guifg='.s:green.rgb.'               guibg='.s:background.rgb.'          '
exec 'hi SignColumn      ctermfg='.s:highlight.ansi.'     ctermbg='.s:background.ansi.'       guifg='.s:highlight.rgb.'        guibg='.s:background.rgb.'          '
exec 'hi VertSplit       ctermfg='.s:green.ansi.'            ctermbg='.s:background.ansi.'       guifg='.s:green.rgb.'               guibg='.s:background.rgb.'          '
exec 'hi MatchParen      ctermfg='.s:green.ansi.'            ctermbg='.s:highlight.ansi.'     guifg='.s:green.rgb.'               guibg='.s:highlight.rgb.'        '
exec 'hi Search          ctermfg='.s:background.ansi.'       ctermbg='.s:reddish_pink.ansi.'     guifg='.s:background.rgb.'          guibg='.s:reddish_pink.rgb.'        '
exec 'hi IncSearch       ctermfg='.s:reddish_pink.ansi.'     ctermbg='.s:background.ansi.'       guifg='.s:reddish_pink.rgb.'        guibg='.s:background.rgb.'          cterm=underline gui=underline'
exec 'hi TabLine         ctermfg='.s:green.ansi.'            ctermbg='.s:background.ansi.'       guifg='.s:green.rgb.'               guibg='.s:background.rgb.'          '
exec 'hi TabLineFill     ctermfg='.s:green.ansi.'            ctermbg='.s:background.ansi.'       guifg='.s:green.rgb.'               guibg='.s:background.rgb.'          '
exec 'hi TabLineSel      ctermfg='.s:highlight.ansi.'     ctermbg='.s:background.ansi.'       guifg='.s:highlight.rgb.'        guibg='.s:background.rgb.'          '
exec 'hi Pmenu           ctermfg='.s:highlight.ansi.'     ctermbg='.s:background.ansi.'       guifg='.s:highlight.rgb.'        guibg='.s:background.rgb.'          '
exec 'hi PmenuSel        ctermfg='.s:magenta.ansi.'          ctermbg='.s:background.ansi.'       guifg='.s:magenta.rgb.'             guibg='.s:background.rgb.'          cterm=bold gui=bold'
exec 'hi PmenuSbar       ctermfg='.s:highlight.ansi.'     ctermbg='.s:background.ansi.'       guifg='.s:highlight.rgb.'        guibg='.s:background.rgb.'          '
exec 'hi PmenuThumb      ctermfg='.s:magenta.ansi.'          ctermbg='.s:background.ansi.'       guifg='.s:magenta.rgb.'             guibg='.s:background.rgb.'          '
exec 'hi Comment         ctermfg='.s:mid_green.ansi.'        ctermbg='.s:background.ansi.'       guifg='.s:mid_green.rgb.'           guibg='.s:background.rgb.'          cterm=italic gui=italic'
exec 'hi SpecialComment  ctermfg='.s:highlight.ansi.'     ctermbg='.s:background.ansi.'       guifg='.s:highlight.rgb.'        guibg='.s:background.rgb.'          cterm=bold gui=bold'
exec 'hi Todo            ctermfg='.s:green.ansi.'            ctermbg='.s:light_green.ansi.'      guifg='.s:green.rgb.'               guibg='.s:light_green.rgb.'         '
exec 'hi Constant        ctermfg='.s:orange.ansi.'           ctermbg='.s:background.ansi.'       guifg='.s:orange.rgb.'              guibg='.s:background.rgb.'          '
exec 'hi Character       ctermfg='.s:magenta.ansi.'          ctermbg='.s:background.ansi.'       guifg='.s:magenta.rgb.'             guibg='.s:background.rgb.'          '
exec 'hi Delimeter       ctermfg='.s:highlight.ansi.'     ctermbg='.s:green.ansi.'            guifg='.s:highlight.rgb.'        guibg='.s:green.rgb.'               '
exec 'hi NvimParenthesis ctermfg='.s:highlight.ansi.'     ctermbg='.s:green.ansi.'            guifg='.s:highlight.rgb.'        guibg='.s:green.rgb.'               '
exec 'hi NvimComma       ctermfg='.s:highlight.ansi.'     ctermbg='.s:green.ansi.'            guifg='.s:highlight.rgb.'        guibg='.s:green.rgb.'               '
exec 'hi NvimColon       ctermfg='.s:highlight.ansi.'     ctermbg='.s:green.ansi.'            guifg='.s:highlight.rgb.'        guibg='.s:green.rgb.'               '
exec 'hi Conditional     ctermfg='.s:magenta.ansi.'          ctermbg='.s:background.ansi.'       guifg='.s:magenta.rgb.'             guibg='.s:background.rgb.'          '
exec 'hi Label           ctermfg='.s:magenta.ansi.'          ctermbg='.s:background.ansi.'       guifg='.s:magenta.rgb.'             guibg='.s:background.rgb.'          '
exec 'hi Operator        ctermfg='.s:red.ansi.'              ctermbg='.s:background.ansi.'       guifg='.s:red.rgb.'                 guibg='.s:background.rgb.'          '
exec 'hi Special         ctermfg='.s:foreground.ansi.'            ctermbg='.s:background.ansi.'       guifg='.s:foreground.rgb.'               guibg='.s:background.rgb.'          '
exec 'hi PreProc         ctermfg='.s:orange.ansi.'           ctermbg='.s:background.ansi.'       guifg='.s:orange.rgb.'              guibg='.s:background.rgb.'          cterm=bold gui=bold'
exec 'hi Statement       ctermfg='.s:red.ansi.'              ctermbg='.s:background.ansi.'       guifg='.s:red.rgb.'                 guibg='.s:background.rgb.'          cterm=bold gui=bold'
exec 'hi Identifier      ctermfg='.s:reddish_pink.ansi.'     ctermbg='.s:background.ansi.'       guifg='.s:reddish_pink.rgb.'        guibg='.s:background.rgb.'          cterm=bold gui=bold'
exec 'hi StorageClass    ctermfg='.s:reddish_pink.ansi.'     ctermbg='.s:background.ansi.'       guifg='.s:reddish_pink.rgb.'        guibg='.s:background.rgb.'          cterm=bold gui=bold'
exec 'hi Type            ctermfg='.s:yellow.ansi.'           ctermbg='.s:background.ansi.'       guifg='.s:yellow.rgb.'              guibg='.s:background.rgb.'          cterm=bold gui=bold'
exec 'hi Error           ctermfg='.s:foreground.ansi.'            ctermbg='.s:red.ansi.'              guifg='.s:foreground.rgb.'               guibg='.s:red.rgb.'                 '
exec 'hi ErrorMsg        ctermfg='.s:foreground.ansi.'            ctermbg='.s:red.ansi.'              guifg='.s:foreground.rgb.'               guibg='.s:red.rgb.'                 '
exec 'hi WarningMsg      ctermfg='.s:foreground.ansi.'            ctermbg='.s:orange.ansi.'           guifg='.s:foreground.rgb.'               guibg='.s:orange.rgb.'              '
exec 'hi Title           ctermfg='.s:magenta.ansi.'          ctermbg='.s:background.ansi.'       guifg='.s:magenta.rgb.'             guibg='.s:background.rgb.'          cterm=bold gui=bold'
exec 'hi markdownIdDeclaration ctermfg='.s:tealish.ansi.'          ctermbg='.s:background.ansi.'       guifg='.s:tealish.rgb.'             guibg='.s:background.rgb.'          cterm=bold gui=bold'
exec 'hi markdownUrl     ctermfg='.s:tealish.ansi.'          ctermbg='.s:background.ansi.'       guifg='.s:tealish.rgb.'             guibg='.s:background.rgb.'          cterm=bold gui=bold'
exec 'hi graphqlStructure ctermfg='.s:red.ansi.'              ctermbg='.s:background.ansi.'       guifg='.s:red.rgb.'                 guibg='.s:background.rgb.'          cterm=bold gui=bold'
exec 'hi graphqlType     ctermfg='.s:yellow.ansi.'           ctermbg='.s:background.ansi.'       guifg='.s:yellow.rgb.'              guibg='.s:background.rgb.'          cterm=bold gui=bold'
exec 'hi yamlKey         ctermfg='.s:red.ansi.'              ctermbg='.s:background.ansi.'       guifg='.s:red.rgb.'                 guibg='.s:background.rgb.'          cterm=bold gui=bold'
exec 'hi yamlBlockMappingKey ctermfg='.s:red.ansi.'              ctermbg='.s:background.ansi.'       guifg='.s:red.rgb.'                 guibg='.s:background.rgb.'          cterm=bold gui=bold'
exec 'hi Directory       ctermfg='.s:magenta.ansi.'          ctermbg='.s:background.ansi.'       guifg='.s:magenta.rgb.'             guibg='.s:background.rgb.'          '
exec 'hi DiffAdd         ctermfg='.s:highlight.ansi.'     ctermbg='.s:background.ansi.'       guifg='.s:highlight.rgb.'        guibg='.s:background.rgb.'          '
exec 'hi diffAdded       ctermfg='.s:highlight.ansi.'     ctermbg='.s:background.ansi.'       guifg='.s:highlight.rgb.'        guibg='.s:background.rgb.'          '
exec 'hi DiffDelete      ctermfg='.s:red.ansi.'              ctermbg='.s:background.ansi.'       guifg='.s:red.rgb.'                 guibg='.s:background.rgb.'          '
exec 'hi diffRemoved     ctermfg='.s:red.ansi.'              ctermbg='.s:background.ansi.'       guifg='.s:red.rgb.'                 guibg='.s:background.rgb.'          '
exec 'hi DiffChange      ctermfg='.s:foreground.ansi.'            ctermbg='.s:background.ansi.'       guifg='.s:foreground.rgb.'               guibg='.s:background.rgb.'          '
exec 'hi DiffText        ctermfg='.s:tealish.ansi.'          ctermbg='.s:background.ansi.'       guifg='.s:tealish.rgb.'             guibg='.s:background.rgb.'          '
exec 'hi diffFile        ctermfg='.s:highlight.ansi.'     ctermbg='.s:background.ansi.'       guifg='.s:highlight.rgb.'        guibg='.s:background.rgb.'          '
exec 'hi gitcommitDiff   ctermfg='.s:reddish_pink.ansi.'     ctermbg='.s:background.ansi.'       guifg='.s:reddish_pink.rgb.'        guibg='.s:background.rgb.'          '
exec 'hi diffIndexLine   ctermfg='.s:yellow.ansi.'           ctermbg='.s:background.ansi.'       guifg='.s:yellow.rgb.'              guibg='.s:background.rgb.'          '
exec 'hi diffLine        ctermfg='.s:magenta.ansi.'          ctermbg='.s:background.ansi.'       guifg='.s:magenta.rgb.'             guibg='.s:background.rgb.'          '
exec 'hi RedrawDebugNormal ctermfg='.s:background.ansi.'       ctermbg='.s:highlight.ansi.'     guifg='.s:background.rgb.'          guibg='.s:highlight.rgb.'        '
exec 'hi RedrawDebugClear ctermfg='.s:background.ansi.'       ctermbg='.s:yellow.ansi.'           guifg='.s:background.rgb.'          guibg='.s:yellow.rgb.'              '
exec 'hi RedrawDebugComposed ctermfg='.s:background.ansi.'       ctermbg='.s:red.ansi.'              guifg='.s:background.rgb.'          guibg='.s:red.rgb.'                 '
exec 'hi RedrawDebugRecompose ctermfg='.s:background.ansi.'       ctermbg='.s:highlight.ansi.'     guifg='.s:background.rgb.'          guibg='.s:highlight.rgb.'        '
exec 'hi ExtraWhitespace ctermfg='.s:magenta.ansi.'          ctermbg='.s:background.ansi.'       guifg='.s:magenta.rgb.'             guibg='.s:background.rgb.'          cterm=underline gui=underline'
exec 'hi NvimInternalError ctermfg='.s:background.ansi.'       ctermbg='.s:red.ansi.'              guifg='.s:background.rgb.'          guibg='.s:red.rgb.'                 '
