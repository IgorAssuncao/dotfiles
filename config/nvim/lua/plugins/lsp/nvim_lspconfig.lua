-- NeoVim LSP
return {
    "neovim/nvim-lspconfig",
    lazy = true,
    opts = {
        inlay_hints = {
            enabled = true
        }
    },
    config = function()
        local lspconfig = require("lspconfig")
        lspconfig.util.default_config = vim.tbl_extend("force",
            lspconfig.util.default_config,
            {
                inlay_hints = {
                    enabled = true
                }
            }
        )
    end
}
