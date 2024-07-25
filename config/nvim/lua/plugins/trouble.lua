return {
    "folke/trouble.nvim",
    event = "VeryLazy",
    dependencies = {
        "git@github.com:nvim-tree/nvim-web-devicons.git"
        -- "nvim-tree/nvim-web-devicons"
    },
    config = function()
        local trouble = require("trouble")
        trouble.setup()

        local which_key = require("which-key")
        which_key.add({
            { "<leader>T",  group = "[T]rouble" },
            { "<leader>TT", function() trouble.open() end,                        desc = "[T]oggle Trouble" },
            { "<leader>Tw", function() trouble.open("workspace_diagnostics") end, desc = "[W]orkspace diagnostics" },
            { "<leader>Td", function() trouble.open("document_diagnostics") end,  desc = "[D]ocument diagnostics" },
            { "<leader>Tq", function() trouble.open("quickfix") end,              desc = "[Q]uickFix" },
            { "<leader>Tl", function() trouble.open("loclist") end,               desc = "[L]ocList" },
            { "<leader>Tr", function() trouble.open("lsp_references") end,        desc = "Lsp [R]eferences" },
        })
    end
}
