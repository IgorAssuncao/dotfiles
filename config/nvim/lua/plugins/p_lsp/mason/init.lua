local mason_ok, mason = pcall(require, "mason")
if not mason_ok then
    vim.notify("Error from p_lsp.mason: mason not found.")
    return
end

local status_mason_lspconfig, mason_lspconfig = pcall(require, "mason-lspconfig")
if not status_mason_lspconfig then
    vim.notify("Error from p_lsp.mason: mason-lspconfig not found.")
    return
end

mason.setup({
    log_level = vim.log.levels.INFO
})

require("plugins.p_lsp.mason.handlers")

local lsp_servers_names = BASE.get_all_lsp_servers_names()

mason_lspconfig.setup {
    ensure_installed = lsp_servers_names,
    automatic_installation = true
}
