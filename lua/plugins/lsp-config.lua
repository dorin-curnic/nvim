return {
	{
		"mason-org/mason.nvim",
		opts = {},
	},
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = {
			"mason-org/mason.nvim",
			"neovim/nvim-lspconfig",
		},
		opts = {
			-- install these servers
			ensure_installed = {
				"pyright", -- Python
				"clangd", -- C / C++
				"ts_ls", -- JavaScript & TypeScript
				"sqlls", -- SQL
				"jdtls", -- Java
				"lua_ls", -- Lua
				"html", -- HTML
				"cssls", -- CSS
				"bzl", -- Bazel / Starlark LSP
			},
			automatic_installation = true,
		},
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local lspconfig = require("lspconfig")
      local keymaps = require("config.keymaps")

			local on_attach = keymaps.lsp_on_attach
			local capabilities = vim.lsp.protocol.make_client_capabilities()

			local servers = {
				"pyright", -- Python
				"clangd", -- C / C++
				"ts_ls", -- JavaScript & TypeScript
				"sqlls", -- SQL
				"jdtls", -- Java
				"lua_ls", -- Lua
				"html", -- HTML
				"cssls", -- CSS
				"bzl", -- Bazel/Starlark
			}

			-- Configure each server:
			for _, name in ipairs(servers) do
				lspconfig[name].setup({
					on_attach = on_attach,
					capabilities = capabilities,
				})
			end
		end,
	},
}

