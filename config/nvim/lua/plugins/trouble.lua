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

        local which_key = require("which-key")
        which_key.add({
            { "<leader>T",   group = "[T]rouble" },
            { "<leader>Td",  group = "[D]iagnostics" },
            { "<leader>Tda", function() trouble.open("diagnostics") end,       desc = "[A]ll" },
            { "<leader>Tde", function() trouble.open("diagnostics_error") end, desc = "[E]rror" },
            { "<leader>Tdw", function() trouble.open("diagnostics_warn") end,  desc = "[W]arning" },
            { "<leader>Ts",  function() trouble.open("symbols") end,           desc = "[S]ymbols" },
            { "<leader>Tq",  function() trouble.open("quickfix") end,          desc = "[Q]uickFix" },
            { "<leader>Tl",  function() trouble.open("loclist") end,           desc = "[L]ocList" },
            { "<leader>Tr",  function() trouble.open("lsp_references") end,    desc = "Lsp [R]eferences" }
        })
    end
}
