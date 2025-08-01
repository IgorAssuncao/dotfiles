-- Plugin that allow fuzzy finding in files,
-- folders, git repo, vim help, grep words.

return {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
        "nvim-lua/plenary.nvim",

        -- Telescope extensions
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
        -- NOTE: Removed project since not being used.
        -- "ahmedkhalf/project.nvim",
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
            },
            extensions = {
                fzf = {
                    fuzzy = true,                   -- false will only do exact matching
                    override_generic_sorter = true, -- override the generic sorter
                    override_file_sorter = true,    -- override the file sorter
                    case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
                    -- the default case_mode is "smart_case"
                }
            }
        }

        local builtin = require("telescope.builtin")

        local wkFindPrefix = "<leader>f"

        which_key.add({
            { wkFindPrefix,         group = "Telescope Fuzzy [F]inder" },
            { wkFindPrefix .. "b",  builtin.current_buffer_fuzzy_find,                                        desc = "Current [b]uffer fuzzy find" },
            { wkFindPrefix .. "f",  builtin.find_files,                                                       desc = "Find [f]iles in cwd" },
            { wkFindPrefix .. "h",  builtin.help_tags,                                                        desc = "[H]elp Tags" },
            { wkFindPrefix .. "l",  builtin.live_grep,                                                        desc = "[L]ive [G]rep" },
            { wkFindPrefix .. "r",  builtin.resume,                                                           desc = "[R]esume" },
            { wkFindPrefix .. "w",  function() builtin.grep_string({ search = vim.fn.input("Grep > ") }) end, desc = "Find [W]ord" },
            { wkFindPrefix .. "g",  group = "[G]it" },
            { wkFindPrefix .. "gb", builtin.git_bcommits,                                                     desc = "[B]ranches" },
            { wkFindPrefix .. "gc", builtin.git_commits,                                                      desc = "[C]ommits" },
            { wkFindPrefix .. "gf", builtin.git_files,                                                        desc = "[F]iles" },
            { wkFindPrefix .. "gs", builtin.git_status,                                                       desc = "Files in git [S]tatus" },
            { wkFindPrefix .. "c",  group = "Todo [c]omments" },
            CreateTodoCommandTable(wkFindPrefix .. "c", "TodoTelescope"),
        })

        -- Extensions
        telescope.load_extension('fzf')

        -- require("project_nvim").setup()
        -- telescope.load_extension("projects")
        -- which_key.add({
        --     { "<leader>fp", function() telescope.extensions.projects.projects {} end, desc = "[P]rojects" }
        -- })

        telescope.load_extension("notify")

        require("git-worktree").setup()
        telescope.load_extension("git_worktree")
        which_key.add({
            { "<leader>gw",  group = "[W]orktrees" },
            { "<leader>gwc", function() telescope.extensions.git_worktree.create_git_worktree() end, desc = "[C]reate Worktree" },
            { "<leader>gwl", function() telescope.extensions.git_worktree.git_worktrees() end,       desc = "[L]ist Worktrees" }
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
