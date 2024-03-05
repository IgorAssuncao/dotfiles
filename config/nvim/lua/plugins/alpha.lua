-- Plugin that allows a nicer startup menu.

vim.api.nvim_create_autocmd("VimEnter", {
    once = true,
    callback = function()
        math.randomseed(os.time())
        local fg_color = tostring(math.random(0, 12))
        local hi_setter = "hi AlphaHeader ctermfg="
        vim.cmd(hi_setter .. fg_color)
    end
})

return {
    "goolord/alpha-nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons"
    },
    config = function()
        local dashboard = require("alpha.themes.dashboard")
        dashboard.section.header.val = {
            " ██╗    ██████╗      ██████╗     ███╗   ██╗ ",
            " ██║    ██╔══██╗    ██╔═████╗    ████╗  ██║ ",
            " ██║    ██████╔╝    ██║██╔██║    ██╔██╗ ██║ ",
            " ██║    ██╔══██╗    ████╔╝██║    ██║╚██╗██║ ",
            " ██║    ██║  ██║    ╚██████╔╝    ██║ ╚████║ ",
            " ╚═╝    ╚═╝  ╚═╝     ╚═════╝     ╚═╝  ╚═══╝ ",
        }
        dashboard.section.buttons.val = vim.tbl_deep_extend(
            "force",
            dashboard.section.buttons.val,
            {
                dashboard.button("q", "󰅚  Quit NVIM", ":qa<CR>"),
                dashboard.button("SPC p", "Open Recent Projects", ":Telescope projects<CR>")
            }
        )
        require("alpha").setup(dashboard.config)
        -- require("alpha").setup(require("alpha.themes.startify").config)
    end
}
