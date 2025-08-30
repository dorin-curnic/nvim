return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		lazy = false,
		dependencies = {
			"nvim-lua/plenary.nvim",

			{
				"nvim-telescope/telescope-ui-select.nvim",
			},
		},
		config = function()
			require("telescope").setup({
				extensions = {
					["ui-select"] = require("telescope.themes").get_dropdown({}),
				},
			})
			-- load
			require("telescope").load_extension("ui-select")
		end,
		--keys = {
			-- Keymaps
			--{ "<S-f>", "<cmd>Telescope find_files<cr>", mode = "n", desc = "Telescope: Find Files" },
			--{ "<S-g>", "<cmd>Telescope live_grep<cr>", mode = "n", desc = "Telescope: Live Grep" },
			--{
				--"<leader>g",
				--function()
					--require("telescope.builtin").live_grep({
						--additional_args = function()
							---- only search this exact filename
							--return { "--glob", vim.fn.expand("%:t") }
						--end,
					--})
				--end,
				--mode = "n",
				--desc = "Telescope: Live Grep in current file",
			--},
		--},
	}
}
