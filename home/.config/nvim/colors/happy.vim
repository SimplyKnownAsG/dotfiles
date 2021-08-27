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
hi Normal          ctermfg=15      ctermbg=0       guifg=#ffffff   guibg=#001b00   
hi ColorColumn                     ctermbg=22                      guibg=#004a00   
hi Cursor                          ctermbg=78                      guibg=#55cf89   
hi CursorLineNr    ctermfg=78      ctermbg=0       guifg=#55cf89   guibg=#001b00   
hi CursorLine      ctermfg=156     ctermbg=0       guifg=#b2ff94   guibg=#001b00   
hi LineNr          ctermfg=28      ctermbg=0       guifg=#238910   guibg=#001b00   
hi NonText         ctermfg=22      ctermbg=0       guifg=#004a00   guibg=#001b00   
hi Conceal         ctermfg=22      ctermbg=0       guifg=#004a00   guibg=#001b00   
hi Ignore          ctermfg=22      ctermbg=0       guifg=#004a00   guibg=#001b00   
hi SignColumn      ctermfg=156     ctermbg=0       guifg=#b2ff94   guibg=#001b00   
hi VertSplit       ctermfg=22      ctermbg=0       guifg=#004a00   guibg=#001b00   
hi MatchParen      ctermfg=22      ctermbg=156     guifg=#004a00   guibg=#b2ff94   
hi Search          ctermfg=0       ctermbg=169     guifg=#001b00   guibg=#cf559c   
hi IncSearch       ctermfg=169     ctermbg=0       guifg=#cf559c   guibg=#001b00   cterm=underline gui=underline
hi TabLine         ctermfg=22      ctermbg=0       guifg=#004a00   guibg=#001b00   
hi TabLineFill     ctermfg=22      ctermbg=0       guifg=#004a00   guibg=#001b00   
hi TabLineSel      ctermfg=78      ctermbg=0       guifg=#55cf89   guibg=#001b00   
hi Pmenu           ctermfg=78      ctermbg=22      guifg=#55cf89   guibg=#004a00   
hi PmenuSel        ctermfg=15      ctermbg=22      guifg=#ffffff   guibg=#004a00   
hi PmenuSbar       ctermfg=78      ctermbg=22      guifg=#55cf89   guibg=#004a00   
hi PmenuThumb      ctermfg=170     ctermbg=22      guifg=#c555cf   guibg=#004a00   
hi Comment         ctermfg=28      ctermbg=0       guifg=#238910   guibg=#001b00   cterm=italic gui=italic
hi SpecialComment  ctermfg=156     ctermbg=0       guifg=#b2ff94   guibg=#001b00   cterm=italic gui=italic
hi Todo            ctermfg=22      ctermbg=77      guifg=#004a00   guibg=#5fcf55   
hi Constant        ctermfg=173     ctermbg=0       guifg=#cf8855   guibg=#001b00   
hi Character       ctermfg=170     ctermbg=0       guifg=#c555cf   guibg=#001b00   
hi Delimeter       ctermfg=156     ctermbg=22      guifg=#b2ff94   guibg=#004a00   
hi NvimParenthesis ctermfg=156     ctermbg=22      guifg=#b2ff94   guibg=#004a00   
hi NvimComma       ctermfg=156     ctermbg=22      guifg=#b2ff94   guibg=#004a00   
hi NvimColon       ctermfg=156     ctermbg=22      guifg=#b2ff94   guibg=#004a00   
hi Conditional     ctermfg=170     ctermbg=0       guifg=#c555cf   guibg=#001b00   
hi Label           ctermfg=170     ctermbg=0       guifg=#c555cf   guibg=#001b00   
hi Operator        ctermfg=167     ctermbg=0       guifg=#cf555f   guibg=#001b00   
hi Special         ctermfg=15      ctermbg=0       guifg=#ffffff   guibg=#001b00   
hi PreProc         ctermfg=173     ctermbg=0       guifg=#cf8855   guibg=#001b00   cterm=bold gui=bold
hi Statement       ctermfg=167     ctermbg=0       guifg=#cf555f   guibg=#001b00   cterm=bold gui=bold
hi Identifier      ctermfg=169     ctermbg=0       guifg=#cf559c   guibg=#001b00   cterm=bold gui=bold
hi StorageClass    ctermfg=169     ctermbg=0       guifg=#cf559c   guibg=#001b00   cterm=bold gui=bold
hi Type            ctermfg=185     ctermbg=0       guifg=#cfc555   guibg=#001b00   cterm=bold gui=bold
hi Error           ctermfg=15      ctermbg=167     guifg=#ffffff   guibg=#cf555f   
hi ErrorMsg        ctermfg=15      ctermbg=167     guifg=#ffffff   guibg=#cf555f   
hi WarningMsg      ctermfg=15      ctermbg=173     guifg=#ffffff   guibg=#cf8855   
hi Title           ctermfg=170     ctermbg=0       guifg=#c555cf   guibg=#001b00   cterm=bold gui=bold
hi markdownIdDeclaration ctermfg=80      ctermbg=0       guifg=#55cfc5   guibg=#001b00   cterm=bold gui=bold
hi markdownUrl     ctermfg=80      ctermbg=0       guifg=#55cfc5   guibg=#001b00   cterm=bold gui=bold
hi graphqlStructure ctermfg=167     ctermbg=0       guifg=#cf555f   guibg=#001b00   cterm=bold gui=bold
hi graphqlType     ctermfg=185     ctermbg=0       guifg=#cfc555   guibg=#001b00   cterm=bold gui=bold
hi yamlKey         ctermfg=167     ctermbg=0       guifg=#cf555f   guibg=#001b00   cterm=bold gui=bold
hi yamlBlockMappingKey ctermfg=167     ctermbg=0       guifg=#cf555f   guibg=#001b00   cterm=bold gui=bold
hi Directory       ctermfg=170     ctermbg=0       guifg=#c555cf   guibg=#001b00   
hi DiffAdd         ctermfg=78      ctermbg=0       guifg=#55cf89   guibg=#001b00   
hi diffAdded       ctermfg=78      ctermbg=0       guifg=#55cf89   guibg=#001b00   
hi DiffDelete      ctermfg=167     ctermbg=0       guifg=#cf555f   guibg=#001b00   
hi diffRemoved     ctermfg=167     ctermbg=0       guifg=#cf555f   guibg=#001b00   
hi DiffChange                      ctermbg=22                      guibg=#004a00   
hi DiffText        ctermfg=80      ctermbg=0       guifg=#55cfc5   guibg=#001b00   
hi diffFile        ctermfg=156     ctermbg=0       guifg=#b2ff94   guibg=#001b00   
hi gitcommitDiff   ctermfg=169     ctermbg=0       guifg=#cf559c   guibg=#001b00   
hi diffIndexLine   ctermfg=185     ctermbg=0       guifg=#cfc555   guibg=#001b00   
hi diffLine        ctermfg=170     ctermbg=0       guifg=#c555cf   guibg=#001b00   
hi RedrawDebugNormal ctermfg=0       ctermbg=156     guifg=#001b00   guibg=#b2ff94   
hi RedrawDebugClear ctermfg=0       ctermbg=185     guifg=#001b00   guibg=#cfc555   
hi RedrawDebugComposed ctermfg=0       ctermbg=167     guifg=#001b00   guibg=#cf555f   
hi RedrawDebugRecompose ctermfg=0       ctermbg=156     guifg=#001b00   guibg=#b2ff94   
hi ExtraWhitespace ctermfg=170     ctermbg=22      guifg=#c555cf   guibg=#004a00   cterm=underline gui=underline
hi NvimInternalError ctermfg=0       ctermbg=167     guifg=#001b00   guibg=#cf555f   
