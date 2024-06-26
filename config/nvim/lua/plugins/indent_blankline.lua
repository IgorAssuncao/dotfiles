-- Plugin for having indentation guide.

vim.opt.list = true
vim.opt.listchars:append "space:⋅"
vim.opt.listchars:append "eol:↴"
-- vim.opt.listchars:append "tab:>"

local background_highlight_groups = {
    "CursorColumn",
    "Whitespace"
}

return {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
        indent = {
            highlight = background_highlight_groups,
            smart_indent_cap = true
        },
        scope = {
            enabled = true,
            highlight = BASE.defaults.highlight_groups,
            show_start = true,
            show_end = true
        },
        whitespace = {
            highlight = background_highlight_groups,
            remove_blankline_trail = true
        },
        -- show_end_of_line = true,
        -- space_char_blankline = " "
    },
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

        require("ibl").setup()
        -- require("ibl").setup {
        --     indent = {
        --         highlight = background_highlight_groups,
        --         smart_indent_cap = true
        --     },
        --     scope = {
        --         enabled = true,
        --         highlight = BASE.defaults.highlight_groups,
        --         show_start = true,
        --         show_end = true,
        --         show_exact_scope = true
        --     },
        --     whitespace = {
        --         highlight = background_highlight_groups,
        --         remove_blankline_trail = true
        --     },
        --     -- show_end_of_line = true,
        --     -- space_char_blankline = " "
        -- }
    end
}
