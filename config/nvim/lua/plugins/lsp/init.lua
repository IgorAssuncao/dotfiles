local lsp = require("lsp-zero")
lsp.preset("recommended")

lsp.ensure_installed({
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
})

-- lsp.nvim_workspace()

local diagnosticsGroup = vim.api.nvim_create_augroup(
	"DiagnosticsGroup",
	{
		clear = true
	}
)

vim.api.nvim_create_autocmd(
	{
		"CursorHold",
		"CursorHoldI"
	},
	{
		pattern = { "*" },
		command = "lua vim.diagnostic.open_float(nil, { focus = false, scope = \"cursor\" })",
		group = diagnosticsGroup
	}
)

vim.api.nvim_create_autocmd(
	{
		"InsertEnter"
	},
	{
		pattern = { "*" },
		command = "lua vim.diagnostic.hide(nil, 0)",
		group = diagnosticsGroup
	}
)

vim.api.nvim_create_autocmd(
	{
		"InsertLeave"
	},
	{
		pattern = { "*" },
		command = "lua vim.diagnostic.show(nil, 0)",
		group = diagnosticsGroup
	}
)

-- LSP auto format
vim.api.nvim_create_autocmd(
	{
		"BufWritePre"
	},
	{
		pattern = { "*" },
		command = "lua vim.lsp.buf.format()"
		-- The format() can also receive an argument
		-- to make formatting async, like:
		-- format({ async = true })
		-- I'm not currently using it because it makes
		-- changes to the buffer after its saved, therefore
		-- entering a loop.
	}
)

-- TODO: Split cmp config into its own file.

local cmp = require("cmp")

local cmp_mappings = lsp.defaults.cmp_mappings()

cmp_mappings["<C-Space>"] = cmp.mapping.complete()
cmp_mappings["<C-Esc>"] = cmp.mapping.abort()
-- cmp_mappings["<C-Tab>"] = function() cmp.select_next_item({ behavior = cmp.SelectBehavior.Select }) end
-- cmp_mappings["<C-S-Tab>"] = function() cmp.select_prev_item() end
-- cmp_mappings["<C-CR>"] = cmp.mapping.confirm({ select = true })

lsp.setup_nvim_cmp({
	mapping = cmp_mappings
})

-- local cmp_config = cmp.get_config()

-- cmp_config.mapping["<C-Tab>"] = cmp.mapping(
--   function()
--     cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
--   end,
--   {"i"}
-- )
-- cmp_config.mapping["<C-S-Tab>"] = cmp.mapping(
--   function()
--     cmp.select_prev_item()
--   end,
--   {"i"}
-- )
-- cmp_config.mapping["<Tab>"] = nil
-- cmp_config.mapping["<S-Tab>"] = nil
-- cmp_config.mapping["<CR>"] = nil

lsp.setup()

vim.diagnostic.config({
	update_in_insert = true,
	severity_sort = true
})

vim.fn.sign_define({
	{
		name = "DiagnosticSignError",
		text = "E",
		texthl = "DiagnosticSignError",
		linehl = "ErrorLine"
	},
	{
		name = "DiagnosticSignWarn",
		text = "W",
		texthl = "DiagnosticSignWarn",
		linehl = "WarnLine"
	},
	{
		name = "DiagnosticSignInfo",
		text = "I",
		texthl = "DiagnosticSignInfo",
		linehl = "InfoLine"
	},
	{
		name = "DiagnosticSignHint",
		text = "H",
		texthl = "DiagnosticSignHint",
		linehl = "HintLine"
	},
})

require("plugins.lsp.keymaps")
