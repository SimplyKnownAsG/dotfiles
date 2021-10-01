set nocompatible
filetype off

nnoremap <Space> <Nop>
let mapleader="\<Space>"

try
    source ~/.config/vim-plug/plug.vim

    call plug#begin('~/.config/vim-plug/plugged')

    Plug 'tpope/vim-fugitive'
    nmap <leader>nd <C-W><C-O>:grep "<<<<"<CR>:Gvdiff<CR><CR>
    nmap <leader>gg <C-W><C-O>:Ggrep<Space>

    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-eunuch'
    Plug 'tpope/vim-unimpaired'
    Plug 'tpope/vim-obsession'
    Plug 'tpope/vim-sleuth'
    Plug 'tpope/vim-markdown'
    let g:markdown_fenced_languages = [
                \ 'html',
                \ 'python',
                \ 'bash=sh',
                \ 'go',
                \ 'typescript',
                \ 'json',
                \ 'yaml',
                \ 'graphql',
                \ 'diff'
                \ ]

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

    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    nmap <leader>gh <Plug>(coc-type-definition)
    nmap <leader>rn <Plug>(coc-rename)
    nmap <leader>lr <Plug>(coc-references)
    " nmap <leader>ph <Plug>()
    nmap <leader>gd <Plug>(coc-definition)
    " nmap <leader>pd <Plug>()
    nmap <leader>fi <Plug>(coc-fix-current)
    nmap <leader>ca :CocAction<CR>
    " nmap <leader>df <Plug>(coc-format-selected)
    " nmap <leader>dd <Plug>(coc-definition)
    " nmap <leader>dn <Plug>(coc-definition)

    " Use tab for trigger completion with characters ahead and navigate.
    " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
    " other plugin before putting this into your config.
    inoremap <silent><expr> <TAB>
          \ pumvisible() ? "\<C-n>" :
          \ <SID>check_back_space() ? "\<TAB>" :
          \ coc#refresh()
    inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

    function! s:check_back_space() abort
        let col = col('.') - 1
        return !col || getline('.')[col - 1]  =~# '\s'
    endfunction

    Plug 'mattn/vim-goimports'

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

    Plug 'ojroques/vim-oscyank'
    let g:oscyank_term='kitty'
    autocmd TextYankPost * if v:event.operator is 'y' && v:event.regname is '' | execute 'OSCYankReg "' | endif

    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    " Set this. Airline will handle the rest.
    let g:airline#extensions#ale#enabled=1
    let g:airline_detect_spell=0
    " let g:airline_section_x = '%{airline#util#prepend(airline#extensions#tagbar#currenttag(),0)}'
    let g:airline_section_z ='%p%%%#__accent_bold#%{g:airline_symbols.linenr}%l%#__restore__#:%v'

    Plug 'MattesGroeger/vim-bookmarks'
    let g:bookmark_disable_ctrlp = 1

    Plug 'jparise/vim-graphql'
    let g:typescript_indent_disable = 1
    Plug 'leafgarland/typescript-vim'
    Plug 'peitalin/vim-jsx-typescript'

    Plug 'stephpy/vim-yaml'
    Plug 'flazz/vim-colorschemes'
    Plug 'sotte/presenting.vim'

    Plug 'google/vim-maktaba'
    Plug 'google/vim-codefmt'
    Plug 'google/vim-glaive'
    nmap <leader>df :FormatCode<CR>

    for source_file in globpath(expand('<sfile>:p:h'), 'more_plug*.vim', 0, 1)
        exec 'source ' . source_file
    endfor

    call plug#end()

    call glaive#Install()
catch
    " don't really care
    echoerr "Caught error: " v:exception
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
    if a:include_test
        let l:files = systemlist('git ls-files')
    else
        let l:files = systemlist('git ls-files | grep -Pv "(Test|\btest\b)"')
    endif
    execute "vimgrep /" . a:pattern . "/g " . join(l:files, ' ')
    copen
    wincmd p
endfunction

nmap <leader>fA :call FindAll(1, @/)<CR><CR>
nmap <leader>fa :call FindAll(0, @/)<CR><CR>

vmap <leader>fA "vy\|/<C-R>v<CR>:call FindAll(1, @v)<CR><CR>
vmap <leader>fa "vy\|/<C-R>v<CR>:call FindAll(0, @v)<CR><CR>

set ruler
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

set background=dark
let g:airline_theme='violet'
colorscheme happy

let g:tex_verbspell=0

autocmd FileType qf wincmd J | vertical resize 10

function! SynStack ()
    for i1 in synstack(line("."), col("."))
        let i2 = synIDtrans(i1)
        let n1 = synIDattr(i1, "name")
        let n2 = synIDattr(i2, "name")
        echo n1 "->" n2
    endfor
endfunction
map SS :call SynStack()<CR>

au BufRead,BufNewFile *.devenv set filetype=sh
