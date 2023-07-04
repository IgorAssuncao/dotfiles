local status_nvim_dap, nvim_dap = pcall(require, "dap")
if not status_nvim_dap then
  vim.notify("Error from plugins.p_nvim-dap: nvim-dap not found.")
  return
end

local status_nvim_dap_virtual_text, nvim_dap_virtual_text = pcall(require, "nvim-dap-virtual-text")
if not status_nvim_dap_virtual_text then
  vim.notify("Error from plugins.p_nvim-dap: nvim-dap-virtual-text not found.")
  return
end

local status_nvim_dap_ui, nvim_dap_ui = pcall(require, "dapui")
if not status_nvim_dap_ui then
  vim.notify("Error from plugins.p_nvim-dap: nvim-dap-ui not found.")
  return
end

nvim_dap_virtual_text.setup()
nvim_dap_ui.setup()

nvim_dap.listeners.after.event_initialized["dapui_config"] = function()
  nvim_dap_ui.open()
end

nvim_dap.listeners.after.event_terminated["dapui_config"] = function()
  nvim_dap_ui.close()
end

nvim_dap.listeners.after.event_exited["dapui_config"] = function()
  nvim_dap_ui.close()
end

local status_mason_registry, mason_registry = pcall(require, "mason-registry")
if not status_mason_registry then
  vim.notify("Error from plugins.p_nvim-dap.rust: mason-registry not found.")
  return
end

local codelldb = mason_registry.get_package("codelldb")
local extension_path = codelldb:get_install_path() .. "/extension/"
local codelldb_path = extension_path .. "adapter/codelldb"

nvim_dap.adapters.codelldb = {
  type = "server",
  port = "${port}",
  executable = {
    command = codelldb_path,
    args = { "--port", "${port}" }
  }
}

local status_neodev, neodev = pcall(require, "neodev")
if not status_neodev then
  vim.notify("Error from plugins.p_nvim-dap: neodev not found.")
  return
end

neodev.setup({
  library = {
    plugins = {
      "nvim-dap-ui"
    },
    types = true
  }
})

local status_which_key, which_key = pcall(require, "which-key")
if not status_which_key then
  vim.notify("Error from plugins.p_nvim-dap: which-key not found.")
  return
end

which_key.register({
  ["<leader>"] = {
    d = {
      name = "[D]ap",
      t = { function() nvim_dap_ui.toggle() end, "[T]oggle UI" },
      b = { function() nvim_dap.toggle_breakpoint() end, "Toggle [B]reakpoint" },
      r = { function() nvim_dap_ui.open({ reset = true }) end, "[R]eset UI" },
      c = { function() nvim_dap.continue() end, "[C]ontinue" },
      s = { function() nvim_dap.terminate() end, "[S]top" }
    }
  }
})

require("plugins.p_nvim-dap.go")
require("plugins.p_nvim-dap.rust")
