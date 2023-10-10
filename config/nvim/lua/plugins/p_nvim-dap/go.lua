local status_dap_go, dap_go = pcall(require, "dap-go")
if not status_dap_go then
    vim.notify("Error from plugins.p_nvim-dap.go: dap-go not found.")
    return
end

dap_go.setup()
