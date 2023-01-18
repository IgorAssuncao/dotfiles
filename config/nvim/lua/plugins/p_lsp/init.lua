PLUGINS.lsp_zero.preset("recommended")

PLUGINS.lsp_zero.ensure_installed({
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
    command = "lua vim.diagnostic.hide(nil, 0)",
    group = diagnosticsGroup
  }
)

vim.api.nvim_create_autocmd(
  {
    "InsertLeave"
  },
  {
    pattern = { "*" },
    command = "lua vim.diagnostic.show(nil, 0)",
    group = diagnosticsGroup
  }
)

-- LSP auto format
vim.api.nvim_create_autocmd(
  {
    "BufWritePre"
  },
  {
    pattern = { "*" },
    command = "lua vim.lsp.buf.format()"
    -- The format() can also receive an argument
    -- to make formatting async, like:
    -- format({ async = true })
    -- I'm not currently using it because it makes
    -- changes to the buffer after its saved, therefore
    -- entering a loop.
  }
)

require("plugins.p_lsp.cmp")

PLUGINS.lsp_zero.setup()

local function eslint_config_exists()
  local eslintrc = vim.fn.glob(".eslintrc*", 0, 1)

  if not vim.tbl_isempty(eslintrc) then
    return true
  end

  if vim.fn.filereadable("package.json") then
    if vim.fn.json_decode(vim.fn.readfile("package.json"))["eslintConfig"] then
      return true
    end
  end
end

PLUGINS.lspconfig.tsserver.setup {
  on_attach = function(client)
    client.server_capabilities.document_formatting = false
  end,
  root_dir = function()
    if not eslint_config_exists() then
      return nil
    end
    return vim.fn.getcwd()
  end,
  filetypes = {
    "javascript",
    "typescript"
  }
}

vim.diagnostic.config({
  update_in_insert = true,
  severity_sort = true
})

-- vim.fn.sign_define({
--   {
--     name = "DiagnosticSignError",
--     text = "E",
--     texthl = "DiagnosticSignError",
--     linehl = "ErrorLine"
--   },
--   {
--     name = "DiagnosticSignWarn",
--     text = "W",
--     texthl = "DiagnosticSignWarn",
--     linehl = "WarnLine"
--   },
--   {
--     name = "DiagnosticSignInfo",
--     text = "I",
--     texthl = "DiagnosticSignInfo",
--     linehl = "InfoLine"
--   },
--   {
--     name = "DiagnosticSignHint",
--     text = "H",
--     texthl = "DiagnosticSignHint",
--     linehl = "HintLine"
--   },
-- })

require("plugins.p_lsp.keymaps")
