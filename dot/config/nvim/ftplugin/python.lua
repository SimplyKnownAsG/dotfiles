-- Short-circuit if already loaded
if vim.g.py_ftplugin_loaded then
  return
end

-- Mark the plugin as loaded
vim.g.py_ftplugin_loaded = true

-- enable pylsp

-- vim.lsp.enable("pylsp")

-- enable ty

vim.lsp.config('ty', {
  cmd = {'uvx', 'ty', 'server'}
})

vim.lsp.enable('ty')

