-- TODO: ensure_lazy function is not working
local ensure_lazy = function()
    -- -- TODO: Custom lazy install_path.
    -- local config_dir = vim.api.nvim_list_runtime_paths()[1]
    -- local install_path = config_dir .. "/lazy.nvim"

    local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
    if not vim.loop.fs_stat(lazypath) then
        vim.fn.system({
            "git",
            "clone",
            "--filter=blob:none",
            "https://github.com/folke/lazy.nvim.git",
            "--branch=stable", -- latest stable release
            lazypath,
        })
    end
    vim.opt.rtp:prepend(lazypath)
end

--TODO: REMOVE THIS PRINT
print(vim.opt.rtp)

local lazy_bootstrap = ensure_lazy()

-- local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
-- if not vim.loop.fs_stat(lazypath) then
--     vim.fn.system({
--         "git",
--         "clone",
--         "--filter=blob:none",
--         "https://github.com/folke/lazy.nvim.git",
--         "--branch=stable", -- latest stable release
--         lazypath,
--     })
-- end
-- vim.opt.rtp:prepend(lazypath)

-- Use a protected call so packer don't error
-- out in first use
local status_lazy, lazy = pcall(require, "lazy")
if not status_lazy then
    vim.notify("Error from plugins.lazy: lazy not found.")
    return
end

-- if lazy_bootstrap then
-- end
lazy.setup("plugins")
