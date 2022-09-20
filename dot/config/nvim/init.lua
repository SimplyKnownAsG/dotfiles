function map(mode, shortcut, command, opts)
    vim.api.nvim_set_keymap(
        mode,
        shortcut,
        command,
        opts or {})
end

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
map('n', ' ', '<Nop>', {noremap=true})

function nmap(shortcut, command)
    map('n', shortcut, command)
end

function mapleader(mode, shortcut, command, opts)
    map(mode, '<leader>' .. shortcut, command, opts)
end

mapleader('n', '<CR>', ':source $MYVIMRC<CR>')

-- {{{ toggle quickfix
function toggle_list(list_name, open_cmd, close_cmd)
    local list_exists = false
    for _, win in pairs(vim.fn.getwininfo()) do
        if win[list_name] == 1 then
            list_exists = true
        end
    end
    if list_exists == true then
        vim.cmd(close_cmd)
    else
        vim.cmd(open_cmd)
    end
end

mapleader('n', 'tq', '<cmd>lua toggle_list("quickfix", "copen | wincmd p", "cclose")<CR>')
mapleader('n', 'tl', '<cmd>lua toggle_list("loclist", "lopen | wincmd p", "lclose")<CR>')
-- }}}

function configure_plugins()
    local packer = require('packer')
    packer.startup(function()
        local use = packer.use
        use 'wbthomason/packer.nvim'

        use 'neovim/nvim-lspconfig'

        use 'mfussenegger/nvim-jdtls'

        use 'tpope/vim-fugitive'
        use 'tpope/vim-commentary'
        use 'tpope/vim-surround'
        use 'tpope/vim-eunuch'
        use 'tpope/vim-unimpaired'
        use 'tpope/vim-obsession'
        use 'tpope/vim-sleuth'
        use 'tpope/vim-markdown'
        vim.g.markdown_folding = 1
        vim.g.markdown_fenced_languages = {
            'html',
            'python',
            'bash=sh',
            'go',
            'typescript',
            'json',
            'yaml',
            'graphql',
            'diff'
        }

        use 'chrisbra/improvedft'

        use 'ctrlpvim/ctrlp.vim'
        vim.g.ctrlp_map = '<leader>ff' -- find file
        vim.g.ctrlp_user_command = 'ag --hidden --ignore .git -g ""'
        vim.g.ctrlp_working_path_mode = 0

        use 'mattn/vim-goimports'

        use 'majutsushi/tagbar'
        vim.g.tagbar_sort=0 -- sort by order in file
        -- Outline
        mapleader('n', 'O', ':TagbarToggle<CR>')
        mapleader('n', 'o', ':TagbarOpenAutoClose<CR>')
        -- vim.g.tagbar_type_go = {
        --     \ 'ctagstype' : 'go',
        --     \ 'kinds'     : [
        --         \ 'p:package',
        --         \ 'i:imports:1',
        --         \ 'c:constants',
        --         \ 'v:variables',
        --         \ 'n:interfaces',
        --         \ 't:types',
        --         \ 'w:fields',
        --         \ 'e:embedded',
        --         \ 'm:methods',
        --         \ 'r:constructor',
        --         \ 'f:functions'
        --     \ ],
        --     \ 'sro' : '.',
        --     \ 'kind2scope' : {
        --         \ 't' : 'ctype',
        --         \ 'n' : 'ntype'
        --     \ },
        --     \ 'scope2kind' : {
        --         \ 'ctype' : 't',
        --         \ 'ntype' : 'n'
        --     \ },
        --     \ 'ctagsbin'  : 'gotags',
        --     \ 'ctagsargs' : '-sort -silent'
        -- \ }


        use 'ntpeters/vim-better-whitespace'
        mapleader('n', 'w', ':StripWhitespace<CR>')

        use 'ojroques/vim-oscyank'
        vim.g.oscyank_term='kitty'
        vim.cmd([[
            autocmd TextYankPost * if v:event.operator is 'y' && v:event.regname is '' | execute 'OSCYankReg "' | endif
        ]])

        -- use 'vim-airline/vim-airline'
        -- use 'vim-airline/vim-airline-themes'
        -- -- Set this. Airline will handle the rest.
        -- vim.g.airline_detect_spell=0
        -- -- vim.g.airline_section_x = '%{airline#util#prepend(airline#extensions#tagbar#currenttag(),0)}'
        -- vim.g.airline_section_z ='%p%%%#__accent_bold#%{g:airline_symbols.linenr}%l%#__restore__#:%v'
        -- vim.g.airline_theme = 'violet'

        use 'MattesGroeger/vim-bookmarks'
        vim.g.bookmark_disable_ctrlp = 1

        use 'jparise/vim-graphql'
        vim.g.typescript_indent_disable = 1
        use 'leafgarland/typescript-vim'
        use 'peitalin/vim-jsx-typescript'

        use 'LnL7/vim-nix'

        use 'stephpy/vim-yaml'
        use 'flazz/vim-colorschemes'
        use 'sotte/presenting.vim'

        use 'google/vim-maktaba'
        use 'google/vim-codefmt'
        use 'google/vim-glaive'
        mapleader('n', 'df', ':FormatCode<CR>')

        use 'prettier/vim-prettier'
        use { 'malmgg@git.amazon.com:pkg/Vim-code-browse' }

    end)
end

vim.api.nvim_set_option("clipboard","unnamed")

vim.cmd('call glaive#Install()')

configure_plugins()

vim.cmd('filetype plugin indent on')

vim.opt.encoding = 'utf-8'
vim.opt.backspace = 'indent,eol,start'
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.ruler = true
-- vim.opt.colorcolumn += 1
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = false

map('', '<C-Tab>', '<C-W>w', {noremap=true})
map('', 'zO', 'zR', {noremap=true})
map('', 'zC', 'zM', {noremap=true})

vim.cmd([[
" Find all, open quickfix
function! FindAll(include_test, pattern)
    if a:include_test
        let l:files = systemlist('ag -g ""')
    else
        let l:files = systemlist('ag -g "" | grep -Pv "(Test|\btest\b)"')
    endif
    execute "vimgrep /" . a:pattern . "/g " . join(l:files, ' ')
    copen
    wincmd p
endfunction
]])

mapleader('n', 'fA', ':call FindAll(1, @/)<CR><CR>')
mapleader('n', 'fa', ':call FindAll(0, @/)<CR><CR>')

mapleader('v', 'fA', [["vy\|/<C-R>v<CR>:call FindAll(1, @v)<CR><CR>]])
mapleader('v', 'fa', [["vy\|/<C-R>v<CR>:call FindAll(0, @v)<CR><CR>]])

vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.infercase = true
vim.opt.hidden = true
vim.opt.autowriteall = true
vim.opt.syntax = 'on'
vim.opt.expandtab = true

vim.opt.grepprg = 'ag --vimgrep'
vim.opt.grepformat = '%f:%l:%c:%m'

vim.opt.background = 'dark'
vim.cmd([[
colorscheme happy

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
]])

local function t(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

vim.opt.completeopt = 'menuone,noselect,noinsert'

-- vim.g.smart_tab = function()
function _G.smart_tab()
    if (vim.fn.pumvisible() == 1)
    then
        return t'<C-n>'
    end

    local col = vim.api.nvim_win_get_cursor(0)[2]

    if (col == 0)
    then
        return t'<TAB>'
    end

    local char = vim.api.nvim_get_current_line():sub(col, col)
    if (char == '.' or char:match('%w'))
    then
        -- return vim.lsp.buf.completion()
        return t'<C-x><C-o>'
    end

    return t'<TAB>'
end

function graham_setloclist()
    vim.diagnostic.setloclist()
    vim.cmd('wincmd p')
end

function graham_setqflist()
    vim.diagnostic.setqflist()
    vim.cmd('wincmd p')
end


vim.g.on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    opts = {noremap=true}
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

    vim.api.nvim_buf_set_keymap(bufnr, 'i', '<TAB>', 'v:lua.smart_tab()', {expr=true, noremap=true})
    vim.api.nvim_buf_set_keymap(bufnr, 'i', '<S-TAB>', 'pumvisible() ? "<C-p>" : "<S-TAB>"', {noremap=true, expr=true})

    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>cl', '<cmd>lua graham_setloclist()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>cq', '<cmd>lua graham_setqflist()<CR>', opts)
end