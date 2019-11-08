if !exists("g:os")
    if has("win64") || has("win32") || has("win32unix") || has("win16")
        " nothing ...
    else
        let g:os = substitute(system('uname'), '\n', '', '')
    endif
endif

set nocompatible
filetype off

nnoremap <Space> <Nop>
let mapleader="\<Space>"

try
    source ~/.config/vim-plug/plug.vim

    call plug#begin('~/.config/vim-plug/plugged')

    Plug 'tpope/vim-fugitive'
    nmap <leader>nd <C-W><C-O>:grep "<<<<"<CR>:Gvdiff<CR><CR>

    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-eunuch'

    Plug 'chrisbra/improvedft'

    Plug 'ctrlpvim/ctrlp.vim'
    let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

    Plug 'yssl/QFEnter'
    let g:qfenter_keymap = {}
    let g:qfenter_keymap.cnext_keep = ['<C-n>']
    let g:qfenter_keymap.cprev_keep = ['<C-p>']
    let g:qfenter_keymap.vopen = ['<C-v>']
    let g:qfenter_keymap.hopen = ['<C-CR>']
    let g:qfenter_keymap.topen = ['<C-t>']

    Plug 'Shougo/vimproc.vim'
    Plug 'rhysd/vim-clang-format'
    let g:clang_format#detect_style_file=1 " use .clang-format
    let g:clang_format#auto_format=1 " format on save
    let g:clang_format#auto_format_on_insert_leave=0

    " Plug 'flazz/vim-colorschemes'
    Plug 'tomasiser/vim-code-dark'
    " Plug 'JulioJu/neovim-colors-solarized-truecolor-only'

    if has("python") || has("python3")
        Plug 'ycm-core/YouCompleteMe'
        let g:ycm_autoclose_preview_window_after_completion=1
        let g:ycm_global_ycm_extra_conf = '~/.config/nvim/ycm_extra_conf.py'
        " go - generic, gh - go to header, gi - go to implementation
        nmap <leader>go :YcmCompleter GoTo<CR>
        nmap <leader>gh :YcmCompleter GoToDeclaration<CR>
        nmap <leader>gd :YcmCompleter GoToDefinition<CR>
        nmap <leader>fi :YcmCompleter FixIt<CR>
        nmap <leader>oi :YcmCompleter OrganizeImports<CR>
    endif

    Plug 'majutsushi/tagbar'
    let g:tagbar_sort=0 " sort by order in file
    " Outline
    nmap <leader>O :TagbarToggle<CR>
    nmap <leader>o :TagbarOpenAutoClose<CR>

    Plug 'ntpeters/vim-better-whitespace'
    nmap <leader>w :StripWhitespace<CR>

    Plug 'w0rp/ale'
    let g:ale_sign_error = 'EE'
    let g:ale_sign_warning = 'WW'
    let g:ale_sign_column_always = 1
    let g:ale_linters = {
    \   'python': ['pylint'],
    \   'c': [],
    \   'cpp': [],
    \   'java': [],
    \   'javascript': [],
    \   'typescript': [],
    \}

    Plug 'vim-airline/vim-airline'
    " Set this. Airline will handle the rest.
    let g:airline#extensions#ale#enabled=1
    let g:airline_detect_spell=0
    if g:os == "Windows"
        let g:airline#parts#ffenc#skip_expected_string='utf-8[dos]'
    else
        let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
    endif
    " let g:airline_section_x = '%{airline#util#prepend(airline#extensions#tagbar#currenttag(),0)}'
    let g:airline_section_z ='%p%%%#__accent_bold#%{g:airline_symbols.linenr}%l%#__restore__#:%v'

    " let g:NERDTreeHijackNetrw=0
    " Plug 'scrooloose/nerdtree'
    " noremap <leader>nt :NERDTreeToggle<CR>
    " noremap <leader>nf :NERDTreeFind<CR>

    Plug 'MattesGroeger/vim-bookmarks'
    let g:bookmark_disable_ctrlp = 1

    Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

    Plug 'lervag/vimtex'
    Plug 'jparise/vim-graphql'
    " let g:typescript_indent_disable = 1
    Plug 'leafgarland/typescript-vim'
    Plug 'peitalin/vim-jsx-typescript'

    call plug#end()
catch
    " dont really care...
endtry

filetype plugin indent on

set encoding=utf-8
set backspace=indent,eol,start


noremap <C-Z> u
noremap <C-S-Z> <C-R>
noremap <C-Tab> <C-W>w
noremap zO zR
noremap zC zM

" Find all, open quickfix
function! FindAll(include_test, pattern)
    execute "grep! \"" . a:pattern . "\""
    if !a:include_test
        let new_results = []
        for qresult in getqflist()
            if bufname(qresult.bufnr) !~ 'TEST'
                call add(new_results, qresult)
            endif
        endfor
        call setqflist(new_results)
    endif
    copen
    wincmd p
endfunction

nmap <leader>fA :call FindAll(1, @/)<CR><CR>
nmap <leader>fa :call FindAll(0, @/)<CR><CR>

vmap <leader>fA "vy\|/<C-R>v<CR>:call FindAll(1, @v)<CR><CR>
vmap <leader>fa "vy\|/<C-R>v<CR>:call FindAll(0, @v)<CR><CR>

set ruler
set textwidth=100
set shiftwidth=4
set tabstop=4
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

function SetGrepPrg()
    let l:git_status_output = system('git status')
    if v:shell_error
        set grepprg=grep\ -rn\ --exclude-dir=.git
    else
        set grepprg=git\ grep\ -n
    endif
endfunction
call SetGrepPrg()

syntax on

if has("gui_running")
    colorscheme solarized
    set background=dark
    set spell spelllang=en_us
    if g:os == "Darwin"
        set guifont=Fira\ Mono:h12
    elseif g:os == "Linux"
        set guifont=Inconsolata\ Medium\ 14
    elseif g:os == "Windows"
        set guifont=Consolas:h10
    endif
else
    " set background=dark
    " let g:solarized_termtrans=1
    " let g:solarized_termcolors=256
    " colorscheme solarized
    let g:airline_theme='codedark'
    colorscheme codedark
endif

let g:tex_verbspell=0
" set spell

command! Inside let g:solarized_termtran=1 | set background=dark | colorscheme solarized
command! Outside let g:solarized_termtran=0 | set background=light | colorscheme solarized

set guioptions-=m "remove menu bar
set guioptions-=T "remove toolbar
set guioptions+=c "use console dialog instead of pop up
set guioptions-=r "remove rich scroll bar
set guioptions-=L "remove left scroll bar

if g:os == "Darwin" && executable('gmake')
    set makeprg=gmake
endif

autocmd FileType qf wincmd J | vertical resize 10

