return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	lazy = false,
	opts = {
		window = {
			position = "right",
			width = 30,
		},
		filesystem = {
			filtered_items = {
				visible = true,
				hide_dotfiles = false,
			},
		},
	},
	config = function(_, opts)
		require("neo-tree").setup(opts)
	end,
	--keys = {
		--vim.keymap.set("n", "<S-b>", ":Neotree toggle position=right<CR>", {}),
	--},
}


