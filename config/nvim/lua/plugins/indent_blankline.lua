-- Plugin for having indentation guide.

vim.opt.list = true
vim.opt.listchars:append "space:⋅"
vim.opt.listchars:append "eol:↴"
-- vim.opt.listchars:append "tab:>"

return {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    -- NOTE: SAME AS SETUP OPTS
    -- opts = {
    --     indent = {
    --         highlight = background_highlight_groups,
    --         smart_indent_cap = true
    --     },
    --     scope = {
    --         enabled = true,
    --         highlight = BASE.defaults.highlight_groups,
    --         show_start = true,
    --         show_end = true
    --     },
    --     whitespace = {
    --         highlight = background_highlight_groups,
    --         remove_blankline_trail = true
    --     },
    -- },
    config = function(_, opts)
        local indent_blankline_hooks = require("ibl.hooks")

        indent_blankline_hooks.register(
            indent_blankline_hooks.type.HIGHLIGHT_SETUP,
            BASE.functions.setup_highlight_groups
        )

        indent_blankline_hooks.register(
            indent_blankline_hooks.type.SCOPE_HIGHLIGHT,
            indent_blankline_hooks.builtin.scope_highlight_from_extmark
        )

        -- require("ibl").setup()
        require("ibl").setup {
            indent = {
                -- char = "▎",
                highlight = {
                    "CursorColumn",
                    "Whitespace",
                    -- "RainbowRed",
                    -- "RainbowBlue",
                    -- "RainbowGreen",
                    -- "RainbowViolet",
                    -- "RainbowCyan",
                    -- "RainbowDelimiterRed",
                    -- "RainbowDelimiterBlue",
                    -- "RainbowDelimiterGreen",
                    -- "RainbowDelimiterViolet",
                    -- "RainbowDelimiterCyan",
                },
                smart_indent_cap = true,
            },
            scope = {
                enabled = true,
                highlight = BASE.defaults.highlight_groups,
                show_start = true,
                show_end = true,
                show_exact_scope = true
            },
            whitespace = {
                highlight = {
                    -- "CursorColumn",
                    "ColorColumn",
                    -- "Whitespace",
                    -- "RainbowRed",
                    -- "RainbowBlue",
                    -- "RainbowGreen",
                    -- "RainbowViolet",
                    -- "RainbowCyan",
                    -- "RainbowDelimiterRed",
                    -- "RainbowDelimiterBlue",
                    -- "RainbowDelimiterGreen",
                    -- "RainbowDelimiterViolet",
                    -- "RainbowDelimiterCyan",
                },
                remove_blankline_trail = true
            },
        }
    end
}
