-- Short-circuit if already loaded
if vim.g.py_ftplugin_loaded then
  return
end

-- Mark the plugin as loaded
vim.g.py_ftplugin_loaded = true

local function get_python_path(workspace)
  -- Use the virtual environment Python if it exists, otherwise fallback
  local venv_path = workspace .. '/.venv/bin/python'
  if vim.fn.executable(venv_path) == 1 then
    return venv_path
  end
  return vim.fn.exepath('python') -- Fallback to system Python
end

require('lspconfig').pylsp.setup({
  on_attach = vim.g.on_attach,
  settings = {
    pylsp = {
      plugins = {
        rope_autoimport = {
          enabled = true
        },
      },
    },
  },
})

require('lspconfig').pyright.setup({
  on_attach = vim.g.on_attach,
  settings = {
    python = {
      pythonPath = get_python_path(vim.fn.getcwd()),
    }
  },
  -- before_init = function(_, config)
  --   config.settings.python.pythonPath = get_python_path(vim.fn.getcwd())
  -- end,
})
