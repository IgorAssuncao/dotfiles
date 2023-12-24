local M = {}

local function print_plugin_require_error(target)
    print("Oops, error requiring: " .. target)
end

function M.protected_require(target)
    local status, t = pcall(require, target)
    if not status then
        print_plugin_require_error(target)
        return
    end
    return t
end

function M.setup_highlight_groups()
    vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
    vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
    vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
    vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
    vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
    vim.api.nvim_set_hl(0, "RainbowDelimiterRed", { fg = "#E06C75" })
    vim.api.nvim_set_hl(0, "RainbowDelimiterGreen", { fg = "#98C379" })
    vim.api.nvim_set_hl(0, "RainbowDelimiterViolet", { fg = "#C678DD" })
    vim.api.nvim_set_hl(0, "RainbowDelimiterBlue", { fg = "#61AFEF" })
    vim.api.nvim_set_hl(0, "RainbowDelimiterCyan", { fg = "#56B6C2" })
end

M.did_init = false
function M:init()
    if not M.did_init then
        M.did_init = true
        require("base.functions")
    end

    return self
end

setmetatable(M, {
    __index = function(_, key)
        M:init()
    end
})

return M
