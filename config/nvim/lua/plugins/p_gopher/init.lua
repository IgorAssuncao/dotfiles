local status, gopher = pcall(require, "gopher")
if not status then
    vim.notify("Error from plugins.p_gopher: gopher not found.")
    return
end

gopher.setup {
    commands = {
        go = "go",
        gomodifytags = "gomodifytags",
        gotests = "gotests",
        impl = "impl",
        iferr = "iferr",
        dlv = "dlv"
    }
}

require("plugins.p_gopher.keymaps")
