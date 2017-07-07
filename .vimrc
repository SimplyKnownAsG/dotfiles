if !exists("g:os")
    if has("win64") || has("win32") || has("win32unix") || has("win16")
        let g:os = "Windows"
        set rtp+=~/codes/.vim/bundle/Vundle.vim
        let path='~/codes/.vim/bundle'
    else
        let g:os = substitute(system('uname'), '\n', '', '')
        set rtp+=~/.vim/bundle/Vundle.vim
        let path='~/.vim/bundle'
    endif
endif

nnoremap <Space> <Nop>
let mapleader="\<Space>"

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
call vundle#begin(path)

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

Plugin 'tpope/vim-fugitive'
nmap <leader>nd <C-W><C-O>:grep "<<<<"<CR>:Gvdiff<CR><CR>

Plugin 'honza/vim-snippets'

Plugin 'tpope/vim-commentary'

Plugin 'chrisbra/improvedft'

Plugin 'ctrlpvim/ctrlp.vim'
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

Plugin 'rhysd/vim-clang-format'
let g:clang_format#detect_style_file=1 " use .clang-format
let g:clang_format#auto_format=1 " format on save
let g:clang_format#auto_format_on_insert_leave=0

Plugin 'flazz/vim-colorschemes'
Plugin 'tomasiser/vim-code-dark'
let g:airline_theme = 'codedark'

if has("python") || has("python3")
    Plugin 'Valloric/YouCompleteMe'
    let g:ycm_autoclose_preview_window_after_completion=1
    " go - generic, gh - go to header, gi - go to implementation
    nmap <leader>go :YcmCompleter GoTo<CR>
    nmap <leader>gh :YcmCompleter GoToDeclaration<CR>
    nmap <leader>gd :YcmCompleter GoToDefinition<CR>
endif

Plugin 'majutsushi/tagbar'
let g:tagbar_sort=0 " sort by order in file
" Outline
nmap <leader>O :TagbarToggle<CR>
nmap <leader>o :TagbarOpenAutoClose<CR>

Plugin 'ntpeters/vim-better-whitespace'
nmap <leader>w :StripWhitespace<CR>

Plugin 'terryma/vim-multiple-cursors'

Plugin 'vim-scripts/DoxygenToolkit.vim'

Plugin 'w0rp/ale'
let g:ale_sign_error = 'EE'
let g:ale_sign_warning = 'WW'
let g:ale_sign_column_always = 1
let g:ale_linters = {
\   'python': ['pylint'],
\}

Plugin 'vim-airline/vim-airline'
" Set this. Airline will handle the rest.
let g:airline#extensions#ale#enabled=1
let g:airline_detect_spell=0
if g:os == "Windows"
    let g:airline#parts#ffenc#skip_expected_string='utf-8[dos]'
else
    let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
endif
let g:airline_section_x = '%{airline#util#prepend(airline#extensions#tagbar#currenttag(),0)}'
let g:airline_section_z ='%p%%%#__accent_bold#%{g:airline_symbols.linenr}%l%#__restore__#:%v'


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

set encoding=utf-8

set backspace=indent,eol,start


noremap <C-Z> u
noremap <C-S-Z> <C-R>
noremap <C-Tab> <C-W>w
noremap zO zR
noremap zC zM

" Find all, open quickfix
nmap <leader>fa :grep! "<C-R>/"<CR>:copen<CR><CR>
vmap <leader>fa "vy\|/<C-R>v<CR>:grep! "<C-R>/"<CR>:copen<CR><CR>

set ruler
set textwidth=120
set colorcolumn=+1
" turn line numbers on
set number
set relativenumber
set nowrap

set hlsearch
set ignorecase
set smartcase
set infercase

set expandtab

if !empty(glob('.git'))
    set grepprg=git\ grep\ -n
else
    set grepprg=grep
endif

syntax on

if has("gui_running")
    colorscheme solarized
    set spell spelllang=en_us
    if g:os == "Darwin"
        set guifont=Fira\ Mono:h12
    elseif g:os == "Linux"
        set guifont=Inconsolata\ Medium\ 14
    elseif g:os == "Windows"
        set guifont=Consolas:h10
    endif
endif

command! Outside set guifont=Consolas:h24 | colorscheme visualstudio

set guioptions-=m "remove menu bar
set guioptions-=T "remove toolbar
set guioptions+=c "remove toolbar

if g:os == "Darwin" && executable('gmake')
    set makeprg=gmake
endif

autocmd BufRead,BufNewFile *.py,*.pyx setlocal shiftwidth=4 tabstop=4 textwidth=100
                        \ makeprg=pylint\ --reports=n\ --output-format=parseable\ --disable=C\ %:p
                        \ errorformat=%f:%l:\ %m
autocmd BufRead,BufNewFile *.tex setlocal shiftwidth=2 tabstop=2 textwidth=100
autocmd BufRead,BufNewFile *.f90,*.rst setlocal shiftwidth=4 tabstop=4 textwidth=100
autocmd BufRead,BufNewFile *.yaml,*.yml setlocal shiftwidth=2 tabstop=2
autocmd BufRead,BufNewFile *.xml,*.mako setlocal shiftwidth=4 tabstop=4 textwidth=100
autocmd BufRead,BufNewFile *.cpp,*.hpp,*.h,*.cxx setlocal shiftwidth=4 tabstop=4 textwidth=100 cino+=g0
autocmd FileType qf wincmd J
autocmd FileType sh setlocal shiftwidth=2 tabstop=2

