-- local file = io.popen("pgrep -a -f -l 'lua-language-server'", "r")
-- local output = file:read("a")
-- file:close()
-- print(output)

return function(opts)
    opts.settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" }
            },
            hint = {
                enable = true
            },
            workspace = {
                library = {
                    [vim.fn.stdpath("config") .. "/lua"] = true,
                    [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                    vim.api.nvim_get_runtime_file("", true)
                },
                checkThirdParty = false
            }
        }
    }
    return opts
end
