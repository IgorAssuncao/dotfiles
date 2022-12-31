local lsp = require('lsp-zero')
lsp.preset('recommended')

-- lsp.ensure_installed({
--   'sumneko_lua',
--   'lua-language-server',
--   'bash-language-server',
--   'awk-language-server',
--   'tsserver',
--   'eslint',
--   'gopls',
--   'rust_analyzer',
--   'jq-lsp',
--   'json-lsp'
--   'terraform-ls',
--   'vim-language-server',
--   'yaml-langugage-server'
--   'sqlls',
--   'dockerfile-language-server',
-- })

lsp.nvim_workspace()

lsp.on_attach(function(client, bufnr)
  local opts = {buffer = bufnr, remap = false}

  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
  vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
  vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
end)

lsp.setup()
