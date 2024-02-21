print(vim.inspect(require('harpoon'):list()))
return {
    "theprimeagen/harpoon",
    branch = "harpoon2",
    dependencies = {
        { "nvim-lua/plenary.nvim" },
        {
            "nvim-telescope/telescope.nvim",
            branch = "0.1.x"
        }
    },
    -- TODO: Load this plugin on keymap.
    -- lazy = true,
    -- keys = {
    --   { "<leader>h", "", desc = "[H]arpoon" }
    -- },
    event = "VeryLazy",
    config = function()
        -- local mark = require('harpoon.mark')
        -- local ui = require('harpoon.ui')

        -- require("which-key").register({
        --     h = {
        --         name = "[H]arpoon",
        --         a = { mark.add_file, "Mark [a]dd file" },
        --         r = { mark.rm_file, "Mark [r]emove file" },
        --         m = { ui.toggle_quick_menu, "UI Toggle" }
        --     }
        -- }, { prefix = "<leader>" })

        local harpoon = require('harpoon')
        harpoon:setup({})

        -- basic telescope configuration
        local conf = require("telescope.config").values
        local function toggle_telescope(harpoon_files)
            local file_paths = {}
            for _, item in ipairs(harpoon_files.items) do
                table.insert(file_paths, item.value)
            end

            require("telescope.pickers").new({}, {
                prompt_title = "Harpoon",
                finder = require("telescope.finders").new_table({
                    results = file_paths,
                }),
                previewer = conf.file_previewer({}),
                sorter = conf.generic_sorter({}),
            }):find()
        end

        require("which-key").register({
            h = {
                name = "[H]arpoon",
                l = { function()
                    toggle_telescope(harpoon:list())
                end, "[L]ist files" },
                a = { function() harpoon:list():append() end, "[A]dd file" },
                r = { function() harpoon:list():remove() end, "[R]emove file" },
            }
        }, { prefix = "<leader>" })
    end
}
