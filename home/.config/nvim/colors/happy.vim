set background=dark
hi clear

if has('termguicolors')
    set termguicolors
endif

if exists("syntax_on")
  syntax reset
endif

" syn match happyPunctuation /[\[(){}\]+*,=_\-!@""#$%^&*<>?\/]/

let colors_name = "happy"
" General colors
hi Normal          ctermfg=15      ctermbg=0       guifg=#ffffff   guibg=#001b00   cterm=NONE gui=NONE
hi ColorColumn                     ctermbg=22                      guibg=#004a00   cterm=NONE gui=NONE
hi Cursor                          ctermbg=78                      guibg=#55cf89   cterm=NONE gui=NONE
hi CursorLine                      ctermbg=78                      guibg=#55cf89   cterm=NONE gui=NONE
hi NonText         ctermfg=22      ctermbg=0       guifg=#004a00   guibg=#001b00   cterm=NONE gui=NONE
hi Conceal         ctermfg=22      ctermbg=0       guifg=#004a00   guibg=#001b00   cterm=NONE gui=NONE
hi Ignore          ctermfg=22      ctermbg=0       guifg=#004a00   guibg=#001b00   cterm=NONE gui=NONE
hi LineNr          ctermfg=22      ctermbg=0       guifg=#004a00   guibg=#001b00   cterm=NONE gui=NONE
hi CursorLineNr    ctermfg=78      ctermbg=0       guifg=#55cf89   guibg=#001b00   cterm=NONE gui=NONE
hi SignColumn      ctermfg=156     ctermbg=0       guifg=#b2ff94   guibg=#001b00   cterm=NONE gui=NONE
hi VertSplit       ctermfg=22      ctermbg=0       guifg=#004a00   guibg=#001b00   cterm=NONE gui=NONE
hi MatchParen      ctermfg=22      ctermbg=156     guifg=#004a00   guibg=#b2ff94   cterm=NONE gui=NONE
hi Search          ctermfg=0       ctermbg=185     guifg=#001b00   guibg=#cfc555   cterm=NONE gui=NONE
hi IncSearch       ctermfg=0       ctermbg=15      guifg=#001b00   guibg=#ffffff   cterm=NONE gui=NONE
hi TabLine         ctermfg=22      ctermbg=0       guifg=#004a00   guibg=#001b00   cterm=NONE gui=NONE
hi TabLineFill     ctermfg=22      ctermbg=0       guifg=#004a00   guibg=#001b00   cterm=NONE gui=NONE
hi TabLineSel      ctermfg=78      ctermbg=0       guifg=#55cf89   guibg=#001b00   cterm=NONE gui=NONE
hi Pmenu           ctermfg=78      ctermbg=22      guifg=#55cf89   guibg=#004a00   cterm=NONE gui=NONE
hi PmenuSel        ctermfg=15      ctermbg=22      guifg=#ffffff   guibg=#004a00   cterm=NONE gui=NONE
hi PmenuSbar       ctermfg=78      ctermbg=22      guifg=#55cf89   guibg=#004a00   cterm=NONE gui=NONE
hi PmenuThumb      ctermfg=170     ctermbg=22      guifg=#c555cf   guibg=#004a00   cterm=NONE gui=NONE
hi Comment         ctermfg=78      ctermbg=0       guifg=#55cf88   guibg=#001b00   cterm=NONE gui=NONE
hi Todo            ctermfg=22      ctermbg=77      guifg=#004a00   guibg=#5fcf55   cterm=NONE gui=NONE
hi Constant        ctermfg=173     ctermbg=0       guifg=#cf8855   guibg=#001b00   cterm=NONE gui=NONE
hi Character       ctermfg=170     ctermbg=0       guifg=#c555cf   guibg=#001b00   cterm=NONE gui=NONE
hi Delimeter       ctermfg=156     ctermbg=22      guifg=#b2ff94   guibg=#004a00   cterm=NONE gui=NONE
hi NvimParenthesis ctermfg=156     ctermbg=22      guifg=#b2ff94   guibg=#004a00   cterm=NONE gui=NONE
hi NvimComma       ctermfg=156     ctermbg=22      guifg=#b2ff94   guibg=#004a00   cterm=NONE gui=NONE
hi NvimColon       ctermfg=156     ctermbg=22      guifg=#b2ff94   guibg=#004a00   cterm=NONE gui=NONE
hi Conditional     ctermfg=170     ctermbg=0       guifg=#c555cf   guibg=#001b00   cterm=NONE gui=NONE
hi Operator        ctermfg=167     ctermbg=0       guifg=#cf555f   guibg=#001b00   cterm=NONE gui=NONE
hi Special         ctermfg=15      ctermbg=0       guifg=#ffffff   guibg=#001b00   cterm=NONE gui=NONE
hi PreProc         ctermfg=173     ctermbg=0       guifg=#cf8855   guibg=#001b00   cterm=bold gui=bold
hi Statement       ctermfg=167     ctermbg=0       guifg=#cf555f   guibg=#001b00   cterm=bold gui=bold
hi Identifier      ctermfg=185     ctermbg=0       guifg=#cfc555   guibg=#001b00   cterm=bold gui=bold
hi Type            ctermfg=185     ctermbg=0       guifg=#cfc555   guibg=#001b00   cterm=bold gui=bold
hi Error           ctermfg=15      ctermbg=167     guifg=#ffffff   guibg=#cf555f   cterm=NONE gui=NONE
hi ErrorMsg        ctermfg=15      ctermbg=167     guifg=#ffffff   guibg=#cf555f   cterm=NONE gui=NONE
hi WarningMsg      ctermfg=15      ctermbg=173     guifg=#ffffff   guibg=#cf8855   cterm=NONE gui=NONE
hi Directory       ctermfg=80      ctermbg=0       guifg=#55cfc5   guibg=#001b00   cterm=NONE gui=NONE
hi DiffAdd         ctermfg=78      ctermbg=0       guifg=#55cf89   guibg=#001b00   cterm=NONE gui=NONE
hi diffAdded       ctermfg=78      ctermbg=0       guifg=#55cf89   guibg=#001b00   cterm=NONE gui=NONE
hi DiffDelete      ctermfg=167     ctermbg=0       guifg=#cf555f   guibg=#001b00   cterm=NONE gui=NONE
hi diffRemoved     ctermfg=167     ctermbg=0       guifg=#cf555f   guibg=#001b00   cterm=NONE gui=NONE
hi DiffChange      ctermfg=170     ctermbg=0       guifg=#c555cf   guibg=#001b00   cterm=NONE gui=NONE
hi DiffText        ctermfg=15      ctermbg=0       guifg=#ffffff   guibg=#001b00   cterm=NONE gui=NONE
hi diffFile        ctermfg=156     ctermbg=0       guifg=#b2ff94   guibg=#001b00   cterm=NONE gui=NONE
hi gitcommitDiff   ctermfg=98      ctermbg=0       guifg=#8855cf   guibg=#001b00   cterm=NONE gui=NONE
hi diffIndexLine   ctermfg=185     ctermbg=0       guifg=#cfc555   guibg=#001b00   cterm=NONE gui=NONE
hi diffLine        ctermfg=170     ctermbg=0       guifg=#c555cf   guibg=#001b00   cterm=NONE gui=NONE
hi RedrawDebugNormal ctermfg=0       ctermbg=156     guifg=#001b00   guibg=#b2ff94   cterm=NONE gui=NONE
hi RedrawDebugClear ctermfg=0       ctermbg=185     guifg=#001b00   guibg=#cfc555   cterm=NONE gui=NONE
hi RedrawDebugComposed ctermfg=0       ctermbg=167     guifg=#001b00   guibg=#cf555f   cterm=NONE gui=NONE
hi RedrawDebugRecompose ctermfg=0       ctermbg=156     guifg=#001b00   guibg=#b2ff94   cterm=NONE gui=NONE
hi ExtraWhitespace                 ctermbg=22                      guibg=#004a00   cterm=NONE gui=NONE
hi NvimInternalError ctermfg=0       ctermbg=167     guifg=#001b00   guibg=#cf555f   cterm=NONE gui=NONE
