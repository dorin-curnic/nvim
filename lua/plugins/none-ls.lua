return {
	"nvimtools/none-ls.nvim",
	config = function()
		local null_ls = require("null-ls")
		null_ls.setup({
			sources = {
				-- formatters
				null_ls.builtins.formatting.black, -- python
                null_ls.builtins.formatting.isort, -- python imports
				null_ls.builtins.formatting.clang_format, -- c++
				null_ls.builtins.formatting.prettier, --prettier
				null_ls.builtins.formatting.sql_formatter, -- sql
				null_ls.builtins.formatting.google_java_format, -- java
				null_ls.builtins.formatting.stylua, -- lua
			    null_ls.builtins.formatting.eslint, -- eslint
            },
		})
	end,
}
