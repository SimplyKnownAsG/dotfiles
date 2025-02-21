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


-- {{{ bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end

vim.opt.rtp:prepend(lazypath)
-- }}}

require("lazy").setup({
  opts = {
    rocks = {
      hererocks = false,
    },
  },
  spec= {
    { 'neovim/nvim-lspconfig', lazy=false, },

    { 'mfussenegger/nvim-jdtls', lazy=false, },

    { 'tpope/vim-fugitive', lazy=false, },
    { 'tpope/vim-commentary', lazy=false, },
    { 'tpope/vim-surround', lazy=false, },
    { 'tpope/vim-eunuch', lazy=false, },
    { 'tpope/vim-unimpaired', lazy=false, },
    { 'tpope/vim-sleuth', lazy=false, },
    { 'tpope/vim-markdown', lazy=false,
      init = function()
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
      end,
    },

    { 'chrisbra/improvedft', lazy=false, },

    { 'ctrlpvim/ctrlp.vim', lazy=false,
      init = function()
        vim.g.ctrlp_map = '<leader>ff' -- find file
        vim.g.ctrlp_user_command = fd_command
        vim.g.ctrlp_working_path_mode = 0
      end,
    },

    { 'majutsushi/tagbar', lazy=false,
      init = function()
        vim.g.tagbar_sort=0 -- sort by order in file
        mapleader('n', 'O', ':TagbarToggle<CR>')
        mapleader('n', 'o', ':TagbarOpenAutoClose<CR>')
      end,
    },
    -- Outline
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


    { 'ntpeters/vim-better-whitespace', lazy=false,
      init = function()
        mapleader('n', 'w', ':StripWhitespace<CR>')
      end
    },

    { 'kamykn/spelunker.vim', lazy=false,
      init = function()
        vim.g.enable_spelunker_vim = 0
      end,
    },

    { 'ojroques/vim-oscyank', lazy=false,
      init = function()
        vim.cmd([[
            autocmd TextYankPost * if v:event.operator is 'y' && v:event.regname is '' | execute 'OSCYankRegister "' | endif
        ]])
      end,
    },

    { 'MattesGroeger/vim-bookmarks', lazy=false,
      init = function()
        vim.g.bookmark_disable_ctrlp = 1
      end,
    },

    { 'jparise/vim-graphql', lazy=false,
      init = function()
        vim.g.typescript_indent_disable = 1
      end,
    },

    { 'leafgarland/typescript-vim', lazy=false, },
    { 'peitalin/vim-jsx-typescript', lazy=false, },

    { 'LnL7/vim-nix', lazy=false, },
    { 'udalov/kotlin-vim', lazy=false, },

    { 'stephpy/vim-yaml', lazy=false, },
    { 'aklt/plantuml-syntax', lazy=false, },
    { 'flazz/vim-colorschemes', lazy=false, },
    { 'sotte/presenting.vim', lazy=false, },
    { 'jbyuki/venn.nvim', lazy=false, },

    -- { 'google/vim-maktaba', lazy=false, },
    -- { 'google/vim-codefmt', lazy=false, },
    -- { 'google/vim-glaive', lazy=false,
    --   init = function()
    --     mapleader('n', 'df', ':FormatCode<CR>')
    --   end,
    -- },

    -- { 'sbdchd/neoformat', lazy=false,
    --   init = function()
    --     mapleader('n', 'df', ':Neoformat<CR>')
    --   end,
    -- },

    { "zenbones-theme/zenbones.nvim",
      -- Optionally install Lush. Allows for more configuration or extending the colorscheme
      -- If you don't want to install lush, make sure to set g:zenbones_compat = 1
      -- In Vim, compat mode is turned on as Lush only works in Neovim.
      dependencies = "rktjmp/lush.nvim",
      lazy = false,
      config = function()
        vim.g.forestbones = { lightness = 'bright', darkness='stark' }
        vim.g.rosebones = { lightness = 'bright', darkness='stark' }

        vim.cmd([[colorscheme rosebones]])
      end,
    },
    { url='malmgg@git.amazon.com:pkg/Vim-code-browse', lazy=false, },
  },
})

vim.api.nvim_set_option("clipboard","unnamed")
vim.api.nvim_set_option("mouse","")

-- configure_plugins()
-- vim.cmd('call glaive#Install()')

-- Function to format the current file with `npx prettier`
_G.format_with_prettier = function()
    local filetype = vim.bo.filetype
    local prettier_filetypes = {
        javascript = true,
        javascriptreact = true,
        typescript = true,
        typescriptreact = true,
        json = true,
        css = true,
        scss = true,
        html = true,
        markdown = true,
        yaml = true,
        yml = true
    }

    if not prettier_filetypes[filetype] then
        return 0
    end

    local bufnr = vim.api.nvim_get_current_buf()
    local bufname = vim.api.nvim_buf_get_name(bufnr)
    local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

    -- Run prettier using vim.fn.system
    local cmd = {
        "npx",
        "prettier",
        "--stdin-filepath="..bufname,
    }

    -- cannot run async, results in an error
    local output = vim.system(cmd, {stdin=lines, text=true}):wait()

    if output.code ~= 0 then
        vim.notify("Prettier failed: " .. output, vim.log.levels.ERROR)
        return 1
    end

    vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, vim.split(output.stdout:gsub("\n+$", ""), "\n"))
end

-- Configure mapleader to run the format function
mapleader('n', 'df', ':lua format_with_prettier()<CR>', { noremap = true, silent = true })

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

-- vim.filetype.add({
--     extension = {
--         devenv = 'sh',
--         log = 'log',
--     },
-- })

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
        -- vim.bo[args.buf].formatexpr = nil
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


-- vim.cmd('autocmd VimEnter * ++nested lua vim.api.nvim_exec_autocmds("FileType", { group = "PrettierFormat" })')

-- Function to run prettier
_G.prettier_format = function()
    local start_line = vim.v.lnum
    print('count: '.. vim.v.count)
    local end_line = start_line + vim.v.count - 1
    local filetype = vim.bo.filetype
    -- Define the file types you want to format with prettier
    local prettier_filetypes = {
        javascript = true,
        javascriptreact = true,
        typescript = true,
        typescriptreact = true,
        json = true,
        css = true,
        scss = true,
        html = true,
        markdown = true,
        yaml = true,
        yml = true
    }

    if not prettier_filetypes[filetype] then
        return 0
    end

    local bufnr = vim.api.nvim_get_current_buf()
    local bufname = vim.api.nvim_buf_get_name(bufnr)
    local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    local range_start = vim.api.nvim_buf_get_offset(bufnr, start_line - 1) + 1
    local range_end = vim.api.nvim_buf_get_offset(bufnr, end_line) - 1

    -- print("Hey Graham, start_line:end_line " .. start_line ..  ":" .. end_line)
    -- print("Hey Graham, let's start at " .. range_start ..  ":" .. range_end)

    -- Run prettier using vim.fn.system
    local cmd = {
        "npx",
        "prettier",
        "--stdin-filepath="..bufname,
        "--range-start="..range_start,
        "--range-end="..range_end
    }

    -- cannot run async, results in an error
    local output = vim.system(cmd, {stdin=lines, text=true}):wait()

    if output.code ~= 0 then
        vim.notify("Prettier failed: " .. output, vim.log.levels.ERROR)
        return 1
    end

    vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, vim.split(output.stdout:gsub("\n+$", ""), "\n"))
end

-- Set formatexpr to use the prettier_format function
local prettier_autogroup = vim.api.nvim_create_augroup("PrettierFormat", { clear=true })
vim.api.nvim_create_autocmd({'FileType'}, {
    group = prettier_autogroup,
    pattern = {
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
      "json",
      "css",
      "scss",
      "html",
      "markdown",
      "yaml",
      "yml",
    },
    callback = function(_ev)
        vim.bo.formatexpr = "v:lua.prettier_format()"
    end
})

vim.opt.sessionoptions:remove({'blank', 'options'})
vim.opt.sessionoptions:append({'tabpages', 'localoptions'})

-- Set formatexpr to use the prettier_format function
-- local session_autogroup = vim.api.nvim_create_augroup("AutoSession", { clear=false })
vim.api.nvim_create_autocmd({'VimLeavePre'}, {
    -- group = session_autogroup,
    callback = function(_ev)
        if vim.v.this_session ~= "" then
            vim.cmd("mksession!")
        end
    end
})
vim.api.nvim_create_autocmd({'BufWinEnter'}, {
    -- group = session_autogroup,
    callback = function(ev)
        if ev["file"] ~= "" or vim.v.this_session ~= "" then
            return
        end

        local f = io.open("Session.vim", "r")

        if f ~= nil and io.close(f) then
            vim.cmd.source {"Session.vim"}
        end
    end
})
