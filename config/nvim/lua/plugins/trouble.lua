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
            auto_preview = false,
            modes = {
                lsp_base = {
                    include_current = true
                },
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

        local wk_trouble_prefix = "<leader>t"

        local which_key = require("which-key")
        which_key.add({
            { wk_trouble_prefix,         group = "[T]rouble" },
            { wk_trouble_prefix .. "d",  group = "[D]iagnostics" },
            { wk_trouble_prefix .. "da", function() trouble.open("diagnostics") end,       desc = "[A]ll" },
            { wk_trouble_prefix .. "de", function() trouble.open("diagnostics_error") end, desc = "[E]rror" },
            { wk_trouble_prefix .. "dw", function() trouble.open("diagnostics_warn") end,  desc = "[W]arning" },
            { wk_trouble_prefix .. "s",  function() trouble.open("symbols") end,           desc = "[S]ymbols" },
            { wk_trouble_prefix .. "q",  function() trouble.open("quickfix") end,          desc = "[Q]uickFix" },
            { wk_trouble_prefix .. "l",  function() trouble.open("loclist") end,           desc = "[L]ocList" },
            { wk_trouble_prefix .. "r",  function() trouble.open("lsp_references") end,    desc = "Lsp [R]eferences" },
            { wk_trouble_prefix .. "c",  group = "Todo [c]omments in Trouble" },
            CreateTodoCommandTable(wk_trouble_prefix .. "c", "TodoTrouble")
        })
    end
}
