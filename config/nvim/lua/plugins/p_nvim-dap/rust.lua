local status_rust_tools, rust_tools = pcall(require, "rust-tools")
if not status_rust_tools then
  vim.notify("Error from plugins.p_nvim-dap.rust: rust-tools not found.")
  return
end

local status_which_key, which_key = pcall(require, "which-key")
if not status_which_key then
  vim.notify("Error from plugins.p_nvim-dap.rust: which-key not found.")
  return
end

local function register_keys(bufnr)
  which_key.register({
    ["L"] = {
      r = {
        name = "[R]ust tools",
        -- Hover Actions
        h = { function() rust_tools.hover_actions.hover_actions() end, "[H]over actions" },
        -- Code action groups
        a = { function() rust_tools.code_action_group.code_action_group() end, "Code [a]ction group" },
      }
    }
  }, { buffer = bufnr })
end

local status_mason_registry, mason_registry = pcall(require, "mason-registry")
if not status_mason_registry then
  vim.notify("Error from plugins.p_nvim-dap.rust: mason-registry not found.")
  return
end

local codelldb = mason_registry.get_package("codelldb")
local extension_path = codelldb:get_install_path() .. "/extension/"
local codelldb_path = extension_path .. "adapter/codelldb"
local liblldb_path = extension_path .. "lldb/lib/liblldb.dylib"

rust_tools.setup({
  dap = {
    -- adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path)
    adapter = require("dap").adapters.codelldb
  },
  server = {
    on_attach = function(_, bufnr)
      register_keys(bufnr)
    end
  },
  tools = {
    hover_actions = {
      auto_focus = true
    }
  }
})
