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

        which_key.register({
            ["<C-\\>"] = {
                name = "Toggleterm",
                d = { function() terms.below:toggle() end, "Toggle terminal below" },
                G = { function() terms.lazygit:toggle() end, "Toggle Lazygit terminal" },
                g = { function() terms.git_dir:toggle() end, "Toggle git dir terminal" },
                h = { function() terms.htop:toggle() end, "Toggle htop terminal" },
            }
        })

        function Toggleterm_set_terminal_keymaps()
            local buffer = 0
            which_key.register({
                ["<C-\\>"] = {
                    name = "Toggleterm",
                    ["<C-\\>"] = { [[<C-\><C-n>]], "Exit insert mode inside terminal" },
                    ["<C-h>"] = { [[<cmd>wincmd h<cr>]], "Move to left terminal" },
                    ["<C-j>"] = { [[<cmd>wincmd j<cr>]], "Move to terminal below" },
                    ["<C-k>"] = { [[<cmd>wincmd k<cr>]], "Move to terminal above" },
                    ["<C-l>"] = { [[<cmd>wincmd l<cr>]], "Move to right terminal" },
                }
            }, { mode = "t", buffer = buffer })
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
