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
      workspace = {
        library = {
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.stdpath("config") .. "/lua"] = true,
        }
        -- library = vim.api.nvim_get_runtime_file("", true), -- This adds the path to every plugin that is installed. If this is not the wanted behavior then change library to vim.fn.stdpath("config")
        -- checkThirdParty = false
      }
    }
  }
  return opts
end
