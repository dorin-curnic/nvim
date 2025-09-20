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
  }
}
