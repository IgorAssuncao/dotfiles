local status_which_key, which_key = false, nil

local rust_tools = nil

local function register_keys(bufnr, wk, rt)
    wk.register({
        ["<leader>L"] = {
            r = {
                name = "[R]ust tools",
                -- Hover Actions
                h = { function() rt.hover_actions.hover_actions() end, "[H]over actions" },
                -- Code action groups
                a = { function() rt.code_action_group.code_action_group() end, "Code [a]ction group" },
            }
        }
    }, { buffer = bufnr })
    -- if which_key and rust_tools then
    --     which_key.register({
    --         ["<leader>L"] = {
    --             r = {
    --                 name = "[R]ust tools",
    --                 -- Hover Actions
    --                 h = { function() rust_tools.hover_actions.hover_actions() end, "[H]over actions" },
    --                 -- Code action groups
    --                 a = { function() rust_tools.code_action_group.code_action_group() end, "Code [a]ction group" },
    --             }
    --         }
    --     }, { buffer = bufnr })
    -- else
    --     print("Error from plugins.rust_tools: which-key or rust-tools not found.")
    -- end
end

-- local status_mason_registry, mason_registry = pcall(require, "mason-registry")
-- if not status_mason_registry then
--   vim.notify("Error from plugins.p_nvim-dap.rust: mason-registry not found.")
--   return
-- end

-- local codelldb = mason_registry.get_package("codelldb")
-- local extension_path = codelldb:get_install_path() .. "/extension/"
-- local codelldb_path = extension_path .. "adapter/codelldb"
-- local liblldb_path = extension_path .. "lldb/lib/liblldb.dylib"

return {
    "simrat39/rust-tools.nvim",
    event = "VeryLazy",
    config = function()
        local status_dap, dap = pcall(require, "dap")
        local dap_settings = {}
        if not status_dap then
            vim.notify("Error from plugins.rust_tools: dap not found.")
        else
            dap_settings = {
                -- adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path)
                adapter = dap.adapters.codelldb
            }
        end

        status_which_key, which_key = pcall(require, "which-key")
        if not status_which_key then
            vim.notify("Error from plugins.rust_tools: which-key not found.")
        end

        rust_tools = require("rust-tools")
        rust_tools.setup({
            dap = dap_settings,
            server = {
                on_attach = function(_, bufnr)
                    BASE.set_lsp_keymaps(bufnr, which_key)
                    register_keys(bufnr, which_key, rust_tools)
                end
            },
            tools = {
                inlay_hints = {
                    auto = false
                },
                hover_actions = {
                    auto_focus = true
                }
            }
        })
    end
}
