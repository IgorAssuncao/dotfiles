-- Plugin that allows better keymapping.

return {
    "folke/which-key.nvim",
    lazy = true,
    config = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 200

        local which_key = require("which-key")
        which_key.setup {}
        which_key.add({
            { "<leader>W",  group = "[W]hich Key" },
            { "<leader>WW", function() vim.cmd { cmd = "WhichKey" } end, desc = "[W]hich [K]ey Toggle" },
            { "<leader>WN", "<cmd>WhichKey '' n<cr>",                    desc = "[W]hich [K]ey [N]ormal mode Toggle" },
            { "<leader>WI", "<cmd>WhichKey '' i<cr>",                    desc = "[W]hich [K]ey [I]nsert mode Toggle" },
            { "<leader>WV", "<cmd>WhichKey '' v<cr>",                    desc = "[W]hich [K]ey [V]isual mode Toggle" },
            { "<leader>WC", "<cmd>WhichKey '' c<cr>",                    desc = "[W]hich [K]ey [C]ommand mode Toggle" },
        })
        which_key.add({
            { "<leader>L", group = "[L]anguages tools" }
        })
    end
}
