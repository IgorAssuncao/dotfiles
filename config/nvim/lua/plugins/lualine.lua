local function window()
    return "W: " .. tostring(vim.api.nvim_win_get_number(0))
end

return {
    "nvim-lualine/lualine.nvim",
    dependencies = {
        "git@github.com:nvim-tree/nvim-web-devicons.git"
        -- "nvim-tree/nvim-web-devicons"
    },
    opts = function(_, opts)
        local trouble = require("trouble")
        local symbols = trouble.statusline({
            mode = "lsp_document_symbols",
            groups = {},
            title = false,
            filter = { range = true },
            format = "{kind_icon}{symbol.name:Normal}",
            -- The following line is needed to fix the background color
            -- Set it to the lualine section you want to use
            -- hl_group = "lualine_x_normal",
        })

        opts.options = {
            theme = "auto" -- or horizon
        }
        opts.sections = {
            lualine_a = { window, "mode" },
            lualine_b = { "branch" },
            lualine_c = { { "filename", path = 1 } },
            lualine_x = {},
            lualine_y = { "diagnostics" },
            lualine_z = { "location" }
        }
        opts.inactive_sections = {
            lualine_a = { window },
            -- lualine_b = { "branch" },
            lualine_c = { { "filename", path = 1 } },
            -- lualine_x = {},
            lualine_y = { "diagnostics" },
            lualine_z = { "location" }
        }
        table.insert(opts.sections.lualine_x, {
            symbols.get,
            cond = symbols.has
        })
        return opts
    end
}
