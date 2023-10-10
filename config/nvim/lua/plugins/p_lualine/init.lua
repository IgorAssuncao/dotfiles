local status_lualine, lualine = pcall(require, "lualine")
if not status_lualine then
    vim.notify("Error from plugins.p_lualine: lualine not found.")
    return
end

local function window()
    return "W: " .. tostring(vim.api.nvim_win_get_number(0))
end

lualine.setup({
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
        -- lualine_y = { "diagnostics" },
        -- lualine_z = { "location" }
    }
})
