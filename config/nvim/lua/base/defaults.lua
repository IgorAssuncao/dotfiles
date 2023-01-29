local M = {}

local defaults = {
  -- load_colorscheme = function(colorscheme_name)
  --   require(colorscheme_name).load()
  -- end,
  lsp_servers = {
    awk = "awk_ls",
    bask = "bashls",
    c = "clangd",
    docker = "dockerls",
    eslint = "eslint",
    go = "gopls",
    grammarly = "grammarly",
    html = "html",
    json = "jsonls",
    lua = "sumneko_lua",
    markdown = "marksman",
    -- "ruff",
    python = "ruff_lsp",
    rust = "rust_analyzer",
    sql = "sqlls",
    toml = "taplo", -- toml
    typescript = "tsserver",
    terraform = "terraformls",
    terraform_lint = "tflint",
    vim = "vimls",
    vue = "vuels",
    yaml = "yamlls",
  },
  icons = {
  	diagnostics = {},
  	git = {},
  	kinds = {
  		Array = "", -- ""
  		Boolean = "",
  		Class = "",
  		Color = "", -- ""
  		Constant = "",
  		Constructor = "",
  		Enum = "",
  		EnumMember = "",
  		Event = "",
  		Field = "",
  		File = "",
  		Folder = "",
  		Function = "",
  		Interface = "",
  		Key = "",
  		Keyword = "",
  		Method = "",
  		Module = "",
  		Namespace = "",
  		Null = "ﳠ",
  		Object = "",
  		Operator = "",
  		Package = "",
  		Property = "",
  		Reference = "",
  		Snippet = "",
  		String = "",
  		Struct = "",
  		Text = "",
  		Type = "",
  		TypeParameter = "",
  		Unit = "",
  		Value = "",
  		Variable = ""
  	}
  }
}

local options = {}

function M.setup(opts)
  M.defaults = defaults
  M.options = vim.tbl_deep_extend("force", options, opts or {})
end

function M.load(opts)
  M.setup()
end

M.did_init = false
function M:init()
  if not M.did_init then
    M.did_init = true
    require("base.defaults").load("options")
  end

  return self
end

setmetatable(M, {
  __index = function(_, key)
    if options == nil then
      M.setup()
    end
    return options[key]
  end
})

function M.get_all_lsp_servers_names()
  local lsp_servers = {}
  for _, v in pairs(M.defaults.lsp_servers) do
    table.insert(lsp_servers, v)
  end
  return lsp_servers
end

return M
