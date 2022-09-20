mapleader('n', 'df', ':FormatCode prettier<CR>')

require('lspconfig').tsserver.setup {
  on_attach = vim.g.on_attach
}
