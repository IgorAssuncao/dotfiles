-- Plugin for having indentation guide.

vim.opt.list = true
vim.opt.listchars:append "space:⋅"
vim.opt.listchars:append "eol:↴"
-- vim.opt.listchars:append "tab:>"

return {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = function()
        local indent_blankline_hooks = require("ibl.hooks")

        indent_blankline_hooks.register(
            indent_blankline_hooks.type.HIGHLIGHT_SETUP,
            BASE.functions.setup_highlight_groups
        )

        indent_blankline_hooks.register(
            indent_blankline_hooks.type.SCOPE_HIGHLIGHT,
            indent_blankline_hooks.builtin.scope_highlight_from_extmark
        )

        vim.g.rainbow_delimiters = { highlight = BASE.defaults.highlight_groups }
        require("ibl").setup {
            -- indent = {
            --     highlight = BASE.defaults.highlight_groups,
            --     smart_indent_cap = true,
            --     char = "|"
            -- },
            scope = {
                enabled = true,
                highlight = BASE.defaults.highlight_groups,
                show_start = true,
                show_end = true,
                show_exact_scope = true,
                char = "|"
            }
        }
    end
}
