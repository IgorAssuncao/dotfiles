return {
    "nvim-tree/nvim-tree.lua",
    -- TODO: Make this plugin lazy load.
    -- lazy = true,
    -- keys = {
    --   { "<leader>nt", function() vim.cmd { cmd = "NvimTreeToggle" } end, desc = "[T]oggle" },
    -- },
    dependencies = {
        "git@github.com:nvim-tree/nvim-web-devicons.git"
        -- "nvim-tree/nvim-web-devicons"
    },
    opts = {
        diagnostics = {
            enable = true,
            show_on_dirs = true
        },
        filters = {
            dotfiles = false
        },
        git = {
            enable = true,
            ignore = false
        },
        renderer = {
            group_empty = false,
            highlight_git = true,
            full_name = true,
            icons = {
                webdev_colors = true,
                git_placement = "before",
                modified_placement = "before",
                show = {
                    file = true,
                    folder = true,
                    folder_arrow = true,
                    git = true
                }
            },
            indent_markers = {
                enable = true,
                icons = {
                    bottom = "-",
                    corner = "└ ",
                    edge = "| ",
                    item = "| ",
                    none = " "
                }
            },
        },
        update_focused_file = {
            enable = false,
            update_cwd = false,
            ignore_list = {}
        },
        view = {
            adaptive_size = true,
            number = true,
            relativenumber = true,
            side = "left",
            float = {
                enable = false
            }
        }
    },
    config = function(_, opts)
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1

        require("nvim-tree").setup(opts)

        require("which-key").register({
            ["<leader>"] = {
                n = {
                    name = "[N]vim-Tree",
                    f = { function() vim.cmd { cmd = "NvimTreeFindFile" } end, "[F]ind File" },
                    t = { function() vim.cmd { cmd = "NvimTreeToggle" } end, "[T]oggle" }
                }
            }
        })
    end
}
