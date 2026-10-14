return {
    settings = {
        Lua = {
            diagnostics = {
                globals = {
                    "vim",
                    "vim.g"
                }
            },
            hint = {
                enable = true
            },
            workspace = {
                checkThirdParty = false,
                library = {
                    [vim.fn.stdpath("config") .. "/lua"] = true,
                    [vim.fn.expand("$VIMRUNTIME/lua")] = true
                }
            }
        }
    }
}
