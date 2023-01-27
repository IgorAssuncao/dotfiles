-- PLUGINS.lsp_zero.preset("recommended")
-- PLUGINS.lsp_zero.ensure_installed(BASE.defaults.lsp_servers)

-- PLUGINS.lsp_zero.setup()
-- PLUGINS.lsp_zero.nvim_workspace()

require("plugins.p_lsp.autocmds")

local function eslint_config_exists()
  local eslintrc = vim.fn.glob(".eslintrc*", 0, 1)

  if not vim.tbl_isempty(eslintrc) then
    return true
  end

  if vim.fn.filereadable("package.json") then
    if vim.fn.json_decode(vim.fn.readfile("package.json"))["eslintConfig"] then
      return true
    end
  end
end

local lsp_keymaps = require("plugins.p_lsp.keymaps").register_lsp_keymaps

local client_capabilities = vim.lsp.protocol.make_client_capabilities()
local cmp_capabilities = require("cmp_nvim_lsp").default_capabilities(client_capabilities)
local capabilities = vim.tbl_deep_extend("force", client_capabilities, cmp_capabilities)

local lsp_servers = BASE.defaults.lsp_servers

local eslint_configs = {
  lintCommand = "eslint_d -f unix --stdin --stdin-filenam ${INPUT}",
  lintStdin = true,
  lintFormats = { "%f:%l:%c: %m" },
  lintIgnoreExitCode = true,
  formatCommand = "eslint_d --fix-to-stdout --stdin --stdin-filename=${INPUT}",
  formatStdin = true,
  format = true
}

-- PLUGINS.lsp.mason_lspconfig.setup_handlers({
require("mason-lspconfig").setup_handlers({
  function(server_name)
    PLUGINS.lsp.lspconfig[server_name].setup {
      autostart = true,
      capabilities = capabilities,
      on_attach = function(_, bufnr)
        lsp_keymaps(bufnr)
      end
    }
  end,
  [lsp_servers.lua] = function()
    PLUGINS.lsp.lspconfig[lsp_servers.lua].setup {
      autostart = true,
      capabilities = capabilities,
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" }
          },
          workspace = {
            library = vim.api.nvim_get_runtime_file("", true), -- This adds the path to every plugin that is installed. If this is not the wanted behavior then change library to vim.fn.stdpath("config")
            checkThirdParty = false
          }
        }
      },
      on_attach = function(_, bufnr)
        lsp_keymaps(bufnr)
      end,
      filetypes = {
        "lua"
      }
    }
  end,
  [lsp_servers.eslint] = function()
    PLUGINS.lsp.lspconfig[lsp_servers.eslint].setup {
      autostart = true,
      capabilities = capabilities,
      -- capabilities = vim.tbl_deep_extend("force", vim.lsp.protocol.make_client_capabilities(), {}),
      -- root_dir = function()
      --   if not eslint_config_exists() then
      --     return nil
      --   end
      --   return vim.fn.getcwd()
      -- end,
      on_attach = function(client, bufnr)
        -- client.server_capabilities.document_formatting = function() if eslint_config_exists() then return true else return false end end
        lsp_keymaps(bufnr)
      end,
      filetypes = {
        "javascript",
        "typescript"
      },
      settings = {
        -- format = function() if eslint_config_exists() then return true else return false end end,
        languages = {
          javascript = { eslint_configs },
          typescript = { eslint_configs }
        }
      }
    }
  end,
  [lsp_servers.typescript] = function()
    PLUGINS.lsp.lspconfig[lsp_servers.typescript].setup {
      autostart = true,
      capabilities = capabilities,
      on_attach = function(client, bufnr)
        -- client.server_capabilities.document_formatting = function() if eslint_config_exists() then return false else return true end end
        lsp_keymaps(bufnr)
      end,
      -- settings = {
      --   format = function() if eslint_config_exists() then return false else return true end end,
      -- }
    }
  end,
  [lsp_servers.terraform] = function()
    PLUGINS.lsp.lspconfig[lsp_servers.terraform].setup {
      autostart = true,
      capabilities = capabilities,
      single_file_support = true,
      filetypes = {
        "terraform",
        "terraform-vars",
        ".tf",
        ".tfvars",
        "*.tfvars*"
      }
    }
  end,
  -- [lsp_servers.terraform_lint] = function()
  --   require("lspconfig")[lsp_servers.terraform_lint].setup {
  --     autostart = true,
  --     capabilities = capabilities,
  --     single_file_support = true,
  --     root_dir = PLUGINS.lsp.lspconfig.util.root_pattern(".terraform", ".git"),
  --     filetypes = {
  --       "terraform",
  --       "terraform-vars",
  --       ".tf",
  --       ".tfvars",
  --       "*.tfvars*"
  --     }
  --   }
  -- end,
  -- local configs = require("lspconfig.configs")
  -- if not configs["tflint"] then
  --   configs["tflint"] = {
  --     default_config = {
  --       cmd = { "tflint" },
  --       filetypes = { "terraform" },
  --       root_dir = PLUGINS.lsp.lspconfig.util.root_pattern(".git")
  --     }
  --   }
  -- end,
  -- PLUGINS.lsp.lspconfig.ruff_lsp.setup {
  --   on_attach = on_attach
  -- },
  -- PLUGINS.lspconfig.server_configurations.setup {
  --   ["ruff"] = {
  --     on_attach = on_attach
  --   }
  -- }
})

local lsp_servers_names = BASE.get_all_lsp_servers()

PLUGINS.lsp.mason.setup()
PLUGINS.lsp.mason_lspconfig.setup {
  ensure_installed = lsp_servers_names,
  automatic_installation = true
}

-- PLUGINS.lspconfig["sumneko_lua"].setup {
--   on_attach = function(client)
--     for k, v in pairs(client) do
--       print(k, v)
--     end
--   end
-- }

vim.diagnostic.config({
  update_in_insert = true,
  severity_sort = true
})

-- vim.fn.sign_define({
--   {
--     name = "DiagnosticSignError",
--     text = "E",
--     texthl = "DiagnosticSignError",
--     linehl = "ErrorLine"
--   },
--   {
--     name = "DiagnosticSignWarn",
--     text = "W",
--     texthl = "DiagnosticSignWarn",
--     linehl = "WarnLine"
--   },
--   {
--     name = "DiagnosticSignInfo",
--     text = "I",
--     texthl = "DiagnosticSignInfo",
--     linehl = "InfoLine"
--   },
--   {
--     name = "DiagnosticSignHint",
--     text = "H",
--     texthl = "DiagnosticSignHint",
--     linehl = "HintLine"
--   },
-- })
