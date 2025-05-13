-- Bridges mason and nvim-lsp
return {
    "mason-org/mason-lspconfig.nvim",
    config = function()
        local mason_lspconfig = require("mason-lspconfig")

        mason_lspconfig.setup {
            ensure_installed = BASE.get_all_lsp_servers_names(),
        }
    end
}
