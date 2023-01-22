local M = {}

local defaults = {
	colorscheme = function(colorscheme_name)
		require(colorscheme_name).load()
	end,
	lsp_servers = {
		"awk_ls",
		"bashls",
		"clangd",
		"cmake",
		"dockerls",
		"gopls",
		"grammarly",
		-- "jqls",
		"jsonls",
		"rust_analyzer",
		"sqlls",
		"sumneko_lua",
		"tsserver",
		"terraformls",
		"vimls",
		"yamlls",
	},
	-- icons = {
	-- 	diagnostics = {},
	-- 	git = {},
	-- 	kinds = {
	-- 		Array = "",
	-- 		Boolean = "",
	-- 		Class = "",
	-- 		Color = "",
	-- 		Constant = "",
	-- 		Constructor = "",
	-- 		Enum = "",
	-- 		EnumMember = "",
	-- 		Event = "",
	-- 		Field = "",
	-- 		File = "",
	-- 		Folder = "",
	-- 		Function = "",
	-- 		Interface = "",
	-- 		Key = "",
	-- 		Keyword = "",
	-- 		Method = "",
	-- 		Module = "",
	-- 		Namespace = "",
	-- 		Null = "",
	-- 		Object = "",
	-- 		Operator = "",
	-- 		Package = "",
	-- 		Property = "",
	-- 		Reference = "",
	-- 		Snippet = "",
	-- 		String = "",
	-- 		Struct = "",
	-- 		Text = "",
	-- 		Type = "",
	-- 		TypeParameter = "",
	-- 		Unit = "",
	-- 		Value = "",
	-- 		Variable = ""
	-- 	}
	-- }
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

return M
