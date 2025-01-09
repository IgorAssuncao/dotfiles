-- Debug Adapter
return {
    "rcarriga/nvim-dap-ui",
    dependencies = {
        {
            "nvim-neotest/nvim-nio",
            "mfussenegger/nvim-dap",
            "folke/neodev.nvim"
        },
    },
    config = function()
        local status_nvim_dap_virtual_text, nvim_dap_virtual_text = pcall(require, "nvim-dap-virtual-text")
        if not status_nvim_dap_virtual_text then
            vim.notify("Error from plugins.debug_adapter: nvim-dap-virtual-text not found.")
            return
        else
            nvim_dap_virtual_text.setup {
                all_references = true
            }
        end

        local nvim_dap_ui = require("dapui")
        nvim_dap_ui.setup()

        local nvim_dap = require("dap")
        nvim_dap.listeners.after.event_initialized["dapui_config"] = function()
            nvim_dap_ui.open()
        end

        -- nvim_dap.listeners.after.event_terminated["dapui_config"] = function()
        --     nvim_dap_ui.close()
        -- end
        --
        -- nvim_dap.listeners.after.event_exited["dapui_config"] = function()
        --     nvim_dap_ui.close()
        -- end

        local codelldb_path = ""

        local status_mason_registry, mason_registry = pcall(require, "mason-registry")
        if not status_mason_registry then
            vim.notify("Error from plugins.debug_adapter.nvim_dap: mason-registry not found.")
        else
            local codelldb = mason_registry.get_package("codelldb")
            local extension_path = codelldb:get_install_path() .. "/extension/"
            codelldb_path = extension_path .. "adapter/codelldb"
        end

        nvim_dap.adapters.codelldb = {
            type = "server",
            port = "${port}",
            executable = {
                command = codelldb_path,
                args = { "--port", "${port}" }
            }
        }

        local neodev = require("neodev")
        neodev.setup({
            library = {
                plugins = {
                    "nvim-dap-ui"
                },
                types = true
            }
        })

        require("which-key").add({
            { "<leader>d",  group = "[D]ap" },
            { "<leader>dt", function() nvim_dap_ui.toggle() end,               desc = "[T]oggle UI" },
            { "<leader>db", function() nvim_dap.toggle_breakpoint() end,       desc = "Toggle [B]reakpoint" },
            { "<leader>dr", function() nvim_dap_ui.open({ reset = true }) end, desc = "[R]eset UI" },
            { "<leader>dc", function() nvim_dap.continue() end,                desc = "[C]ontinue" },
            { "<leader>ds", function() nvim_dap.terminate() end,               desc = "[S]top" }
        })
    end
}
