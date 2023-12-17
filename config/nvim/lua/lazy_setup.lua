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

ensure_lazy()
