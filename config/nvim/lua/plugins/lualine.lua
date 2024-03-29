local function window()
    return "W: " .. tostring(vim.api.nvim_win_get_number(0))
end

return {
    "nvim-lualine/lualine.nvim",
    dependencies = {
        "git@github.com:nvim-tree/nvim-web-devicons.git"
        -- "nvim-tree/nvim-web-devicons"
    },
    opts = {
        options = {
            theme = "auto" -- or horizon
        },
        sections = {
            lualine_a = { window, "mode" },
            lualine_b = { "branch" },
            lualine_c = { { "filename", path = 1 } },
            -- lualine_x = {},
            lualine_y = { "diagnostics" },
            lualine_z = { "location" }
        },
        inactive_sections = {
            lualine_a = { window },
            -- lualine_b = { "branch" },
            lualine_c = { { "filename", path = 1 } },
            -- lualine_x = {},
            lualine_y = { "diagnostics" },
            -- lualine_z = { "location" }
        }
    }
}
