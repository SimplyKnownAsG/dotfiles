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
    Plug 'tpope/vim-unimpaired'
    Plug 'tpope/vim-obsession'

    Plug 'chrisbra/improvedft'

    Plug 'ctrlpvim/ctrlp.vim'
    let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

    Plug 'yssl/QFEnter'
    let g:qfenter_keymap = {}
    let g:qfenter_keymap.cnext_keep = ['<C-n>']
    let g:qfenter_keymap.cprev_keep = ['<C-p>']
    let g:qfenter_keymap.vopen = ['<C-v>']
    let g:qfenter_keymap.hopen = ['<C-s>']
    let g:qfenter_keymap.topen = ['<C-t>']

    Plug 'Shougo/vimproc.vim'

    Plug 'SimplyKnownAsG/vim-code-dark'

    Plug 'prabirshrestha/async.vim'

    " performance issues
    let g:lsp_highlights_enabled = 0
    let g:lsp_textprop_enabled = 0
    let g:lsp_fold_enabled = 0
    set completeopt-=preview
    Plug 'prabirshrestha/vim-lsp'

    Plug 'mattn/vim-lsp-settings'
    ", {'tag': 'v0.0.1'}
    nmap <leader>gh :LspDeclaration<CR>
    nmap <leader>ph :LspPeekDeclaration<CR>
    nmap <leader>gd :LspDefinition<CR>
    nmap <leader>pd :LspPeekDefinition<CR>
    nmap <leader>fi :LspCodeAction<CR>
    nmap <leader>df :LspDocumentFormatSync<CR>
    nmap <leader>dd :LspDocumentDiagnostics<CR>
    nmap <leader>dn :LspNextDiagnostic<CR>

    Plug 'prabirshrestha/asyncomplete.vim'
    inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
    inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
    inoremap <expr> <cr>    pumvisible() ? "\<C-y>" : "\<cr>"
    Plug 'prabirshrestha/asyncomplete-lsp.vim'
    Plug 'prabirshrestha/async.vim'

    if filereadable('.clang-format')
        Plug 'rhysd/vim-clang-format'
        let g:clang_format#detect_style_file=1 " use .clang-format
        let g:clang_format#auto_format=1 " format on save
        let g:clang_format#auto_format_on_insert_leave=0
    else
        " autocmd BufWritePre * :LspDocumentFormatSync
        " autocmd! BufWritePre *.go :LspDocumentFormatSync
    endif

    Plug 'mattn/vim-goimports'
    Plug 'prettier/vim-prettier', { 'do': 'yarn install' }

    Plug 'majutsushi/tagbar'
    let g:tagbar_sort=0 " sort by order in file
    " Outline
    nmap <leader>O :TagbarToggle<CR>
    nmap <leader>o :TagbarOpenAutoClose<CR>
    let g:tagbar_type_go = {
        \ 'ctagstype' : 'go',
        \ 'kinds'     : [
            \ 'p:package',
            \ 'i:imports:1',
            \ 'c:constants',
            \ 'v:variables',
            \ 'n:interfaces',
            \ 't:types',
            \ 'w:fields',
            \ 'e:embedded',
            \ 'm:methods',
            \ 'r:constructor',
            \ 'f:functions'
        \ ],
        \ 'sro' : '.',
        \ 'kind2scope' : {
            \ 't' : 'ctype',
            \ 'n' : 'ntype'
        \ },
        \ 'scope2kind' : {
            \ 'ctype' : 't',
            \ 'ntype' : 'n'
        \ },
        \ 'ctagsbin'  : 'gotags',
        \ 'ctagsargs' : '-sort -silent'
    \ }


    Plug 'ntpeters/vim-better-whitespace'
    nmap <leader>w :StripWhitespace<CR>

    " Plug 'w0rp/ale'
    " let g:ale_sign_error = 'EE'
    " let g:ale_sign_warning = 'WW'
    " let g:ale_sign_column_always = 1
    " let g:ale_linters = {
    " \   'python': ['pylint'],
    " \   'c': [],
    " \   'cpp': [],
    " \   'java': [],
    " \   'javascript': [],
    " \   'typescript': [],
    " \}

    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
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

    Plug 'MattesGroeger/vim-bookmarks'
    let g:bookmark_disable_ctrlp = 1

    " Plug 'lervag/vimtex'
    Plug 'jparise/vim-graphql'
    let g:typescript_indent_disable = 1
    Plug 'leafgarland/typescript-vim'
    Plug 'peitalin/vim-jsx-typescript'

    Plug 'stephpy/vim-yaml'
    Plug 'altercation/vim-colors-solarized'
    Plug 'flazz/vim-colorschemes'

    for source_file in globpath(expand('<sfile>:p:h'), 'more_plug*.vim', 0, 1)
        exec 'source ' . source_file
    endfor

    call plug#end()
catch
    " don't really care
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
    let friendly_pattern = substitute(substitute(a:pattern, '\\<', '\\b', "g"), '\\>', '\\b', "g")
    execute "grep! \"" . friendly_pattern . "\""
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
if exists('&colorcolumn')
    set colorcolumn=+1
endif
" turn line numbers on
set number
if exists('&relativenumber')
    set relativenumber
endif
set nowrap

set hlsearch
set ignorecase
set smartcase
set infercase
set hidden
set autowriteall
syntax on
set expandtab

set grepprg=ag\ --vimgrep
set grepformat=%f:%l:%c:%m

if has("gui_running")
    set spell spelllang=en_us
    if g:os == "Darwin"
        set guifont=Fira\ Mono:h12
    elseif g:os == "Linux"
        set guifont=Inconsolata\ Medium\ 14
    elseif g:os == "Windows"
        set guifont=Consolas:h10
    endif
else
    set background=dark
    let g:airline_theme='solarized'
    try
        colorscheme happy
    catch
        " whatever
    endtry
endif

let g:tex_verbspell=0

if g:os == "Darwin" && executable('gmake')
    set makeprg=gmake
endif

autocmd FileType qf wincmd J | vertical resize 10
autocmd FileType java setlocal shiftwidth=2 tabstop=2
