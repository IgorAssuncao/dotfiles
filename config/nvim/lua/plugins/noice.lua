-- Plugin for having the vim window in the center
-- of the screen.

return {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
        { "MunifTanjim/nui.nvim" },
        -- { "rcarriga/nvim-notify" }
    },
    opts = {
        lsp = {
            override = {
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                ["vim.lsp.util.stylize_markdown"] = true,
                ["cmp.entry.get_documentation"] = true
            },
        },
        presets = {
            bottom_search = true,
            command_palette = false,
            long_message_to_split = true,
            inc_rename = false,
            lsp_doc_border = true
        },
        views = {
            cmdline_popup = {
                position = {
                    row = "40%",
                    col = "50%"
                },
                size = {
                    width = 60,
                    height = "auto"
                }
            },
            popupmenu = {
                relative = "editor",
                position = {
                    row = "50%",
                    col = "50%",
                },
                size = {
                    width = 60,
                    height = 10,
                },
                border = {
                    style = "rounded",
                    padding = { 0, 1 },
                },
                win_options = {
                    winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
                },
            }
        }
    }
}
