-- Short-circuit if already loaded
if vim.g.ts_ftplugin_loaded then
  return
end

-- Mark the plugin as loaded
vim.g.ts_ftplugin_loaded = true
vim.lsp.enable("ts_ls")
