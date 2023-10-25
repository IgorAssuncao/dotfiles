local status_lspconfig, lspconfig = pcall(require, "lspconfig")
if not status_lspconfig then
    vim.notify("Error from plugins.p_lsp.mason-handlers: lspconfig not found.")
    return
end

local status_cmp_nvim_lsp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_cmp_nvim_lsp then
    vim.notify("Error from plugins.p_lsp.mason-handlers: cmp_nvim_lsp not found")
    return
end

local client_capabilities = vim.lsp.protocol.make_client_capabilities()
local cmp_capabilities = cmp_nvim_lsp.default_capabilities()
local capabilities = vim.tbl_deep_extend("force", client_capabilities, cmp_capabilities)

local register_lsp_keymaps = require("plugins.p_lsp.keymaps").register_lsp_keymaps

local status_mason_lspconfig, mason_lspconfig = pcall(require, "mason-lspconfig")
if not status_mason_lspconfig then
    vim.notify("Error from p_lsp.mason: mason-lspconfig not found.")
    return
end

local status_lsp_inlay_hints, lsp_inlay_hints = pcall(require, "lsp-inlayhints")
if not status_lsp_inlay_hints then
    vim.notify("Error form p_lsp.mason: lsp-inlayhints not found.")
    return
end

lsp_inlay_hints.setup {
    inlay_hints = {
        labels_separator = " - ",
        parameter_hints = {
            show = true,
            prefix = "PT: <- ",
            separator = ", ",
            remove_colon_start = false,
            remove_colon_end = true,
        },
        type_hints = {
            -- type and other hints
            show = true,
            prefix = "RT: ",
            separator = ", ",
            remove_colon_start = false,
            remove_colon_end = false,
        },
    }
}

local default_setup_opts = {
    capabilities = capabilities,
    single_file_support = true,
    on_attach = function(client, bufnr)
        register_lsp_keymaps(bufnr)

        if client.name == "tsserver" then
            -- client.server_capabilities.codeActionProvider = false
            client.server_capabilities.documentFormattingProvider = false
            client.server_capabilities.documentRangeFormattingProvider = false
            -- elseif client.name == "terraform-ls" then
            --     client.capabilities.experimental.showReferencesCommandId = "client.showReferences"
            --     client.capabilities.refreshModuleProviders = "client.refreshModuleProviders"
            --     client.capabilities.refreshModuleCalls = "client.refreshModuleCalls"
        end
    end
}

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        if not (args.data and args.data.client_id) then
            return
        end

        local bufnr = args.buf
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        lsp_inlay_hints.on_attach(client, bufnr, true)

        -- vim.lsp.codelens.display(
        --     vim.lsp.codelens.get(bufnr),
        --     bufnr,
        --     client.id
        -- )
    end
})

mason_lspconfig.setup_handlers({
    function(server_name)
        lspconfig[server_name].setup(default_setup_opts)
    end
})

local lsp_servers = BASE.defaults.lsp_servers

for k, v in pairs(lsp_servers) do
    local require_ok, server_setup = pcall(require, "plugins.p_lsp.mason.servers." .. k)
    if require_ok then
        local opts = {}

        local default_opts = vim.tbl_deep_extend("force", default_setup_opts, {})

        local server_opts = server_setup(default_opts)
        opts = vim.tbl_deep_extend("force", default_opts, server_opts)

        -- else
        --   vim.notify("Error from plugins.p_lsp.mason.handlers: requiring servers." .. k .. " not found.")

        lspconfig[v].setup(opts)
    end
end

--   lspconfig[lsp_servers.terraform_lint].setup {
--     capabilities = capabilities,
--     root_dir = lspconfig.util.root_pattern(".terraform", ".git"),
--     filetypes = {
--       "terraform",
--       "terraform-vars",
--       ".tf",
--       ".tfvars",
--       "*.tfvars*"
--     }
--   }
-- local configs = require("lspconfig.configs")
-- if not configs["tflint"] then
--   configs["tflint"] = {
--     default_config = {
--       cmd = { "tflint" },
--       filetypes = { "terraform" },
--       root_dir = lspconfig.util.root_pattern(".git")
--     }
--   }
-- end,
-- lspconfig.ruff_lsp.setup {
--   on_attach = on_attach
-- },
-- lspconfig.server_configurations.setup {
--   ["ruff"] = {
--     on_attach = on_attach
--   }
-- }
