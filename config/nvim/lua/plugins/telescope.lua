-- Plugin that allow fuzzy finding in files,
-- folders, git repo, vim help, grep words.

return {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        -- Telescope extensions
        "ahmedkhalf/project.nvim",
        "ThePrimeagen/git-worktree.nvim",
        -- NOTE: Check note near EOF.
        -- {
        --     "theprimeagen/harpoon",
        --     branch = "harpoon2",
        --     dependencies = { "nvim-lua/plenary.nvim" },
        -- }
    },
    config = function()
        local telescope = require("telescope")

        local status_trouble, trouble = pcall(require, "trouble.sources.telescope")
        local mappings = {}
        if not status_trouble then
            vim.notify("Error from plugins.telescope: trouble not found.\nUnable to bind trouble keymaps to telescope")
        else
            mappings = {
                i = { ["<c-t>"] = trouble.open },
                n = { ["<c-t>"] = trouble.open }
            }
        end

        local which_key = require("which-key")

        telescope.setup {
            defaults = {
                file_ignore_patterns = {
                    "packer.nvim",
                    "undodir",
                    "node_modules",
                    "venv",
                    "plugin/packer_compiled.lua",
                },
                layout_config = {
                    horizontal = {
                        prompt_position = "top"
                    }
                },
                mappings = mappings,
                pickers = {
                    find_files = {
                        hidden = true
                    },
                    live_grep = {
                        only_sort_text = true
                    },
                    grep_string = {
                        only_sort_text = true
                    }
                },
                -- path_display = { "smart" },
                sorting_strategy = "ascending"
            }
        }

        local builtin = require("telescope.builtin")

        which_key.add({
            { "<leader>f",  group = "Telescope Fuzzy [F]inder" },
            { "<leader>fb", builtin.current_buffer_fuzzy_find,                                        desc = "Current [b]uffer fuzzy find" },
            { "<leader>ff", builtin.find_files,                                                       desc = "Find [f]iles in cwd" },
            { "<leader>fh", builtin.help_tags,                                                        desc = "[H]elp Tags" },
            { "<leader>fl", builtin.live_grep,                                                        desc = "[L]ive [G]rep" },
            { "<leader>fr", builtin.resume,                                                           desc = "[R]esume" },
            { "<leader>fw", function() builtin.grep_string({ search = vim.fn.input("Grep > ") }) end, desc = "Find [W]ord" },
            { "<leader>fg", group = "[G]it" },
            { "<leader>fg", builtin.git_bcommits,                                                     desc = "[B]commits" },
            { "<leader>fg", builtin.git_commits,                                                      desc = "[C]ommits" },
            { "<leader>fg", builtin.git_files,                                                        desc = "[F]iles" },
            { "<leader>fg", builtin.git_status,                                                       desc = "Files in git [S]tatus" },
        })

        -- Extensions
        local project = require("project_nvim")
        project.setup()
        telescope.load_extension("projects")
        which_key.add({
            { "<leader>fp", function() telescope.extensions.projects.projects {} end, desc = "[P]rojects" }
        })

        -- telescope.load_extension("notify")

        require("git-worktree").setup()
        telescope.load_extension("git_worktree")
        which_key.add({
            { "<leader>gw", group = "[W]orktrees" },
            { "<leadergwc", function() telescope.extensions.git_worktree.create_git_worktree() end, desc = "[C]reate Worktree" },
            { "<leadergwl", function() telescope.extensions.git_worktree.git_worktrees() end,       desc = "[L]ist Worktrees" }
        })

        -- NOTE: Attempt to integrate harpoon2 into telescope
        -- local harpoon = require("harpoon")
        -- harpoon:setup({})
        -- telescope.load_extension("harpoon")
        -- which_key.add({
        --     {"<leader>hu", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, desc = "Toggle [U]I" },
        -- })
    end
}
