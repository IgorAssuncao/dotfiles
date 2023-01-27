PLUGINS.lsp_zero.preset("recommended")

PLUGINS.lsp_zero.ensure_installed(BASE.defaults.lsp_servers)

require("plugins.p_lsp.autocmds")

PLUGINS.lsp_zero.setup()
PLUGINS.lsp_zero.nvim_workspace()

require("plugins.p_cmp")

-- PLUGINS.lspconfig["sumneko_lua"].setup {
--   on_attach = function(client)
--     for k, v in pairs(client) do
--       print(k, v)
--     end
--   end
-- }

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
