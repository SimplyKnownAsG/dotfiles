-- Short-circuit if already loaded
if vim.g.ts_ftplugin_loaded then
  return
end

-- Mark the plugin as loaded
vim.g.ts_ftplugin_loaded = true

-- Your LSP setup for TypeScript
require('lspconfig').ts_ls.setup {
  on_attach = vim.g.on_attach
}
