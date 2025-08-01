return {
    "folke/trouble.nvim",
    event = "VeryLazy",
    dependencies = {
        "git@github.com:nvim-tree/nvim-web-devicons.git"
        -- "nvim-tree/nvim-web-devicons"
    },
    config = function()
        local trouble = require("trouble")
        trouble.setup({
            modes = {
                diagnostics_error = {
                    mode = "diagnostics",
                    filter = { severity = vim.diagnostic.severity.ERROR }
                },
                diagnostics_warn = {
                    mode = "diagnostics",
                    filter = { severity = vim.diagnostic.severity.WARN }
                }
            }
        })

        local wkTroublePrefix = "<leader>t"

        local which_key = require("which-key")
        which_key.add({
            { wkTroublePrefix,         group = "[T]rouble" },
            { wkTroublePrefix .. "d",  group = "[D]iagnostics" },
            { wkTroublePrefix .. "da", function() trouble.open("diagnostics") end,       desc = "[A]ll" },
            { wkTroublePrefix .. "de", function() trouble.open("diagnostics_error") end, desc = "[E]rror" },
            { wkTroublePrefix .. "dw", function() trouble.open("diagnostics_warn") end,  desc = "[W]arning" },
            { wkTroublePrefix .. "s",  function() trouble.open("symbols") end,           desc = "[S]ymbols" },
            { wkTroublePrefix .. "q",  function() trouble.open("quickfix") end,          desc = "[Q]uickFix" },
            { wkTroublePrefix .. "l",  function() trouble.open("loclist") end,           desc = "[L]ocList" },
            { wkTroublePrefix .. "r",  function() trouble.open("lsp_references") end,    desc = "Lsp [R]eferences" },
            { wkTroublePrefix .. "c",  group = "Todo [c]omments in Trouble" },
            CreateTodoCommandTable(wkTroublePrefix .. "c", "TodoTrouble")
        })
    end
}
