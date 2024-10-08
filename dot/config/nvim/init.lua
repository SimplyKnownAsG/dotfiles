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
nmap('<C-l>', ':tabn<CR>')
nmap('<C-h>', ':tabp<CR>')

local fd_command = 'fd -t f --exclude=Session.vim --exclude="*.class"'

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


-- {{{ bootstrap packer
local bootstrap_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return require('packer').sync
  end
  return function()
      -- do nothing
  end
end

local sync_packer = bootstrap_packer()
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
        vim.g.ctrlp_user_command = fd_command
        vim.g.ctrlp_working_path_mode = 0

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

        use 'kamykn/spelunker.vim'
        vim.g.enable_spelunker_vim = 0
        use 'ojroques/vim-oscyank'
        vim.cmd([[
            autocmd TextYankPost * if v:event.operator is 'y' && v:event.regname is '' | execute 'OSCYankRegister "' | endif
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
        use 'udalov/kotlin-vim'

        use 'stephpy/vim-yaml'
        use 'aklt/plantuml-syntax'
        use 'flazz/vim-colorschemes'
        use 'sotte/presenting.vim'
        use 'jbyuki/venn.nvim' -- diagram

        use 'google/vim-maktaba'
        use 'google/vim-codefmt'
        use 'google/vim-glaive'
        mapleader('n', 'df', ':FormatCode<CR>')

        use 'prettier/vim-prettier'
        use { 'malmgg@git.amazon.com:pkg/Vim-code-browse' }

        sync_packer()
    end)
end

vim.api.nvim_set_option("clipboard","unnamed")
vim.api.nvim_set_option("mouse","")

configure_plugins()
vim.cmd('call glaive#Install()')

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
vim.opt.textwidth = 120

map('', '<C-Tab>', '<C-W>w', {noremap=true})
map('', 'zO', 'zR', {noremap=true})
map('', 'zC', 'zM', {noremap=true})

vim.cmd([[
" Find all, open quickfix
function! FindAll(include_test, pattern)
    if a:include_test
        let l:files = systemlist(']] .. fd_command .. [[')
    else
        let l:files = systemlist(']] .. fd_command .. [[ | grep -Pv "(Test[^a-z]|\btest\b)"')
    endif
    execute "vimgrep /" . a:pattern . "/g " . join(l:files, ' ')
    copen
    wincmd p
endfunction
]])

function find_all_ish(include_test)
    local mode = vim.api.nvim_get_mode()["mode"]
    local pattern = ""
    local cmd = {
        "ag",
        "--vimgrep",
        "--ignore", "Session.vim",
        "-s"
    }

    if mode == "n" then
        cmd[#cmd+1] = "-w" -- only match full words
        pattern = vim.fn.expand("<cword>")
    elseif mode == "v" then
        local vstart = vim.fn.getpos("v")
        local vend = vim.fn.getpos(".")
        local line_start = vstart[2]
        local line_end = vend[2]

        if line_start ~= line_end then
            vim.api.nvim_err_writeln('ERROR: query cannot span multiple lines!')
            return
        end

        local the_line = vim.fn.getline(line_start)

        pattern = string.sub(vim.fn.getline(line_start), math.min(vstart[3], vend[3]), math.max(vstart[3], vend[3]))
    end

    if pattern == nil or pattern == "" then
        vim.api.nvim_err_writeln("ERROR: couldn't find the pattern to search with mode: " .. mode)
        return
    end

    if not include_test then
        cmd[#cmd+1] = '--ignore'
        cmd[#cmd+1] = '*Test.*'
        cmd[#cmd+1] = '--ignore'
        cmd[#cmd+1] = '*.test.*'
        cmd[#cmd+1] = '--ignore'
        cmd[#cmd+1] = '*-test-*'
    end

    cmd[#cmd+1] = pattern

    local lines = vim.fn.systemlist(cmd)
    vim.fn.setqflist({}, 'r', {title=table.concat(cmd, " "); lines = lines})
    vim.cmd.copen()
end

local find_all = function() find_all_ish(true) end
local find_all_no_test = function() find_all_ish(false) end

mapleader('n', 'fA', '<cmd>lua find_all_ish(true)<CR>')
mapleader('n', 'fa', '<cmd>lua find_all_ish(false)<CR>')

mapleader('v', 'fA', '<cmd>lua find_all_ish(true)<CR>')
mapleader('v', 'fa', '<cmd>lua find_all_ish(false)<CR>')

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

pcall(require, "background")

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
]])

vim.filetype.add({
    extension = {
        devenv = 'sh',
        log = 'log',
    },
})

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
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    -- vim.keymap.set('n', '<leader>f', vim.lsp.buf.formatting, opts)

    vim.api.nvim_buf_set_keymap(bufnr, 'i', '<TAB>', 'v:lua.smart_tab()', {expr=true, noremap=true})
    vim.api.nvim_buf_set_keymap(bufnr, 'i', '<S-TAB>', 'pumvisible() ? "<C-p>" : "<S-TAB>"', {noremap=true, expr=true})

    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>cl', '<cmd>lua graham_setloclist()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>cq', '<cmd>lua graham_setqflist()<CR>', opts)
end

-- https://vi.stackexchange.com/a/39800/22825
-- gq uses lsp format now?
vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        -- disable LSP usage for `gq` cause it doesn't work on comments.
        vim.bo[args.buf].formatexpr = nil
        -- disable @lsp highlight groups
        for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
            vim.api.nvim_set_hl(0, group, {})
        end
    end,
})

-- local generalSettingsGroup = vim.api.nvim_create_augroup('Textwidth', { clear = true })
-- vim.api.nvim_create_autocmd('FileType', {
--     pattern = { '*.ts', '*.tsx', '*.js', '*.jsx' },
--     callback = function()
--         vim.opt.textwidth = 120
--     end,
--     group = generalSettingsGroup,
-- })
