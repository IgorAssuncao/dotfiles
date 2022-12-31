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
  local opts = { buffer = bufnr, remap = false }

  local keybind = vim.keymap.set

  keybind("n", "gd", function() vim.lsp.buf.definition() end, opts)
  keybind("n", "K", function() vim.lsp.buf.hover() end, opts)
  keybind("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
  keybind("n", "[d", function() vim.diagnostic.goto_next() end, opts)
  keybind("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
end)

local cmp = require("cmp")

local cmp_mappings = lsp.defaults.cmp_mappings()

cmp_mappings["<C-Space>"] = cmp.mapping.complete()
cmp_mappings["<C-Esc>"] = cmp.mapping.abort()
-- cmp_mappings["<C-Tab>"] = function() cmp.select_next_item({ behavior = cmp.SelectBehavior.Select }) end
-- cmp_mappings["<C-S-Tab>"] = function() cmp.select_prev_item() end
-- cmp_mappings["<C-CR>"] = cmp.mapping.confirm({ select = true })

lsp.setup_nvim_cmp({
  mapping = cmp_mappings
})

lsp.setup()

-- local cmp_config = cmp.get_config()

-- cmp_config.mapping["<C-Tab>"] = cmp.mapping(
--   function()
--     cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
--   end,
--   {"i"}
-- )
-- cmp_config.mapping["<C-S-Tab>"] = cmp.mapping(
--   function()
--     cmp.select_prev_item()
--   end,
--   {"i"}
-- )
-- cmp_config.mapping["<Tab>"] = nil
-- cmp_config.mapping["<S-Tab>"] = nil
-- cmp_config.mapping["<CR>"] = nil

