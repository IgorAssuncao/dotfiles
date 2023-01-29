require("plugins.p_lsp.autocmds")
require("plugins.p_lsp.mason")

vim.diagnostic.config({
  update_in_insert = true,
  underline = true,
  severity_sort = true,
  float = {
    focusable = false,
    style = "minimal",
    border = "rounded",
    source = "always"
  }
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
