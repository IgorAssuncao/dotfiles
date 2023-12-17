vim.opt.list = true
vim.opt.listchars:append "space:⋅"
vim.opt.listchars:append "eol:↴"
-- vim.opt.listchars:append "tab:>"

local highlight_colors = {
  "RainbowRed",
  "RainbowGreen",
  "RainbowViolet",
  "RainbowBlue",
  "RainbowCyan"
}

local background_highlight_colors = {
  "CursorColumn",
  "Whitespace"
}

return {
  "lukas-reineke/indent-blankline.nvim",
  config = function()
    local indent_blankline_hooks = require("ibl.hooks")

    indent_blankline_hooks.register(indent_blankline_hooks.type.HIGHLIGHT_SETUP, function()
      vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
      vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
      vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
      vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
      vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
    end)

    require("ibl").setup {
      indent = {
        char = "",
        highlight = background_highlight_colors,
        smart_indent_cap = true
      },
      scope = {
        enabled = true,
        highlight = highlight_colors,
        show_start = true,
        show_end = true
      },
      whitespace = {
        -- highlight = background_highlight_colors,
        remove_blankline_trail = true
      },
      -- show_end_of_line = true,
      -- space_char_blankline = " "
    }
  end
}
