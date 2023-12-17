return {
	"folke/trouble.nvim",
	dependencies = {
		"git@github.com:nvim-tree/nvim-web-devicons.git"
		-- "nvim-tree/nvim-web-devicons"
	},
	config = function()
		local trouble = require("trouble")
		trouble.setup()

		local which_key = require("which-key")
		which_key.register({
			["<leader>"] = {
				T = {
					name = "[T]rouble",
					{
						T = { function() trouble.open() end, "[T]oggle Trouble" },
						w = { function() trouble.open("workspace_diagnostics") end, "[W]orkspace diagnostics" },
						d = { function() trouble.open("document_diagnostics") end, "[D]ocument diagnostics" },
						q = { function() trouble.open("quickfix") end, "[Q]uickFix" },
						l = { function() trouble.open("loclist") end, "[L]ocList" },
						r = { function() trouble.open("lsp_references") end, "Lsp [R]eferences" }
					}
				}
			}
		})
	end
}
