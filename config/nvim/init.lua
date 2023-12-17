-- Lazy explicitly asks to map the leader key before loading itself.
vim.g.mapleader = " "

-- Bootstrap package manager first
-- because I use whick key as the default keymapper
require("lazy_setup")

require("base")

-- Use a protected call so lazy don't error
-- out in first use
local status_lazy, lazy = pcall(require, "lazy")
if not status_lazy then
    vim.notify("Error from plugins.lazy: lazy not found.")
    return
end

lazy.setup({
    {
        "iamcco/markdown-preview.nvim",
        build = "cd app & npm install",
        config = function()
            vim.g.mkdp_filetypes = { "markdown" }
        end,
        ft = { "markdown" }
    },
    spec = {
        { import = "plugins" },
        { import = "plugins.lsp" },
        { import = "plugins.debug_adapter" }
    }
})

-- keymaps is being required after lazy
-- because of which-key plugin that registers keymaps.
require("base.keymaps")

require("after")
