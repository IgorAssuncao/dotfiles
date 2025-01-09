-- Plugin that allows me to have a nicer terminal
-- inside Nvim.

return {
    "akinsho/toggleterm.nvim",
    -- TODO: Lazy load this plugin.
    -- lazy = true,
    -- keys = { "<C-\\>t" },
    event = "VeryLazy",
    config = function()
        local toggleterm = require("toggleterm")

        toggleterm.setup({
            direction = "float",
            open_mapping = [[<C-\>t]],
            insert_mappings = false,
            close_on_exit = true
        })

        local terminal = require("toggleterm.terminal").Terminal

        local terms = {
            below = terminal:new({ direction = "horizontal", close_on_exit = true }),
            git_dir = terminal:new({ dir = "git_dir", direction = "float" }),
            lazygit = terminal:new({ cmd = "lazygit", hidden = true, close_on_exit = true }),
            htop = terminal:new({ cmd = "htop", hidden = true, close_on_exit = true })
        }

        local which_key = require("which-key")

        which_key.add({
            { "<C-\\>",  group = "Toggleterm" },
            { "<C-\\>d", function() terms.below:toggle() end,   desc = "Toggle terminal below" },
            { "<C-\\>G", function() terms.lazygit:toggle() end, desc = "Toggle Lazygit terminal" },
            { "<C-\\>g", function() terms.git_dir:toggle() end, desc = "Toggle git dir terminal" },
            { "<C-\\>h", function() terms.htop:toggle() end,    desc = "Toggle htop terminal" },
        })

        function Toggleterm_set_terminal_keymaps()
            local buffer = 0

            which_key.add({
                mode = { "t", buffer = buffer },
                { "<C-\\>", group = "Toggleterm" },
                { "<C-\\>", [[<C-\><C-n>]],        desc = "Exit insert mode inside terminal" },
                { "<C-h>",  [[<cmd>wincmd h<cr>]], desc = "Move to left terminal" },
                { "<C-j>",  [[<cmd>wincmd j<cr>]], desc = "Move to terminal below" },
                { "<C-k>",  [[<cmd>wincmd k<cr>]], desc = "Move to terminal above" },
                { "<C-l>",  [[<cmd>wincmd l<cr>]], desc = "Move to right terminal" },
            })
        end

        vim.api.nvim_create_autocmd(
            {
                "TermOpen"
            },
            {
                pattern = "term://*toggleterm#*",
                command = "lua Toggleterm_set_terminal_keymaps()"
            }
        )
    end
}
