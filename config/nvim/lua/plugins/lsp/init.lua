vim.diagnostic.config({
    update_in_insert = true,
    underline = false,
    severity_sort = true,
    virtual_text = true,
    float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "always"
    }
})

return {}
