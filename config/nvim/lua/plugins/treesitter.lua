return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    lazy = false,
    dependencies = {
        -- Treesitter extensions
        -- "nvim-treesitter/playground",
        "nvim-treesitter/nvim-treesitter-context"
    },
    init = function()
        require("nvim-treesitter.configs").setup(
            {
                -- A list of parser names, or "all"
                ensure_installed = {
                    "bash",
                    "c",
                    "dockerfile",
                    "git_config",
                    "git_rebase",
                    "gitattributes",
                    "gitcommit",
                    "gitignore",
                    "go",
                    "gomod",
                    "gosum",
                    "gowork",
                    "hcl",
                    "javascript",
                    "jq",
                    "jsdoc",
                    "json",
                    "lua",
                    -- "make",
                    -- "markdown",
                    -- "markdown_inline",
                    "python",
                    "regex",
                    "rust",
                    -- "sql",
                    "terraform",
                    "toml",
                    -- "tsx",
                    -- "typescript",
                    "vim",
                    "vimdoc",
                    -- "vue",
                    "yaml",
                },
                auto_install = true,
                highlight = {
                    enable = true,
                },
                indent = {
                    enable = true
                },
                -- nvim-ts-playground plugin
                -- playground = {
                --     enable = true,
                --     disable = {},
                --     updatetime = 25,
                --     persist_queries = false,
                --     keybinding = {
                --         toggle_query_editor = "o",
                --         toggle_hl_groups = "i",
                --         toggle_injected_languages = "t",
                --         toggle_anonymous_modes = "a",
                --         toggle_language_display = "i",
                --         focus_language = "f",
                --         unfocus_language = "F",
                --         update = "R",
                --         goto_node = "<cr>",
                --         show_help = "?"
                --     }
                -- }
            }
        )
        require 'treesitter-context'.setup {
            multiwindow = true
        }
    end
}
