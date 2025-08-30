return {
    "numToStr/Comment.nvim",
    opts = {},
    config = function(_, opts)
        require("Comment").setup(opts)

        local map = vim.keymap.set
        -- allow remapping so that "gcc" triggers the plugin's own mapping
        map("n", "<D-/>", "gcc", { silent = true, remap = true, desc = "Toggle comment line"})
        map("v", "<D-/>", "gc", { silent = true, remap = true, desc = "Toggle comment selection" })
    end,
}
