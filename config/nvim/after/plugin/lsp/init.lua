local lsp = require("lsp-zero")
lsp.preset("recommended")

lsp.ensure_installed({
  "awk_ls",
  "bashls",
  "clangd",
  "cmake",
  "dockerls",
  "gopls",
  "grammarly",
  -- "jqls",
  "jsonls",
  "rust_analyzer",
  "sqlls",
  "sumneko_lua",
  "tsserver",
  "terraformls",
  "vimls",
  "yamlls",
})

-- lsp.nvim_workspace()

local diagnosticsGroup = vim.api.nvim_create_augroup(
  "DiagnosticsGroup",
  {
    clear = true
  }
)

vim.api.nvim_create_autocmd(
  {
    "CursorHold",
    "CursorHoldI"
  },
  {
    pattern = { "*" },
    command = "lua vim.diagnostic.open_float(nil, { focus = false, scope = \"cursor\" })",
    group = diagnosticsGroup
  }
)

vim.api.nvim_create_autocmd(
  {
    "InsertEnter"
  },
  {
    pattern = { "*" },
    command = "lua vim.diagnostic.hide()",
    group = diagnosticsGroup
  }
)

vim.api.nvim_create_autocmd(
  {
    "InsertLeave"
  },
  {
    pattern = { "*" },
    command = "lua vim.diagnostic.show()",
    group = diagnosticsGroup
  }
)

-- LSP auto format
vim.api.nvim_create_autocmd(
  {
    "BufWrite"
  },
  {
    pattern = { "*" },
    command = "lua vim.lsp.buf.format()"
  }
)

-- TODO: Split cmp config into its own file.

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

lsp.setup()

vim.diagnostic.config({
  update_in_insert = true
})
