PLUGINS.lsp_zero.preset("recommended")

PLUGINS.lsp_zero.ensure_installed(BASE.defaults.lsp_servers)

-- lsp.nvim_workspace()

require("plugins.p_lsp.autocmds")

PLUGINS.lsp_zero.setup()

require("plugins.p_cmp")

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
