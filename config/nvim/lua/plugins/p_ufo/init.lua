local status_ufo, ufo = pcall(require, "ufo")
if not status_ufo then
    vim.notify("Error from plugins.p_ufo not found.")
    return
end

vim.o.foldlevelstart = 99

ufo.setup({
    provider_selector = function(bufnr, filetype, buftype)
        return { "lsp", "indent" }
        -- return { "treesitter", "indent" }
    end
})
