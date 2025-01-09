-- Plugin for having Git related signs in Nvim.

return {
    "lewis6991/gitsigns.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim"
    },
    event = "VeryLazy",
    config = function()
        require("gitsigns").setup {
            numhl = true,
            linehl = false,
            current_line_blame = false,
        }

        require("which-key").add({
            { "<leader>gB", function() vim.cmd.Gitsigns { args = { "toggle_current_line_blame" } } end, desc = "Toggle line [b]lame" },
            { "<leader>gh", function() vim.cmd.Gitsigns { args = { "preview_hunk_inline" } } end,       desc = "Preview [h]unk inline" },
            { "<leader>gD", function() vim.cmd.Gitsigns { args = { "diffthis" } } end,                  desc = "[D]iff this file" },
            { "<leader>gL", function() vim.cmd.Gitsigns { args = { "toggle_linehl" } } end,             desc = "Toggle [L]ine highlight" },
        })
    end
}
