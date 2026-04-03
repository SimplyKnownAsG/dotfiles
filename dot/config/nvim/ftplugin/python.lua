-- Short-circuit if already loaded
if vim.g.py_ftplugin_loaded then
  return
end

-- Mark the plugin as loaded
vim.g.py_ftplugin_loaded = true

vim.lsp.config('ty', {
  cmd = {'uvx', 'ty', 'server'}
})

vim.lsp.enable('ty')

