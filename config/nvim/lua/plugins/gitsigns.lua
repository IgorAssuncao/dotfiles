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
        }

        require("which-key").register({
            g = {
                B = {
                    function() vim.cmd.Gitsigns { args = { "toggle_current_line_blame" } } end,
                    "Toggle line [b]lame"
                },
                h = {
                    function() vim.cmd.Gitsigns { args = { "preview_hunk_inline" } } end, "Preview [h]unk inline"
                },
                D = {
                    function() vim.cmd.Gitsigns { args = { "diffthis" } } end, "[D]iff this file"
                },
                L = {
                    function() vim.cmd.Gitsigns { args = { "toggle_linehl" } } end, "Toggle [L]ine highlight"
                }
            }
        }, { prefix = "<leader>" })
    end
}
