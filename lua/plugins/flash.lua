return {
  {
    "folke/flash.nvim",
    event = "VeryLazy",

    ---@type Flash.Config
    opts = {
      labels = "asdfghjklqwertyuiopzxcvbnm",

      search = {
        multi_window = true,
        forward = true,
        wrap = true,
      },

      jump = {
        autojump = false,
      },

      label = {
        rainbow = {
          enabled = true,
          shade = 5,
        },
      },

      modes = {
        char = {
          enabled = true,
        },
      },
    },

    keys = {
      {
        "s",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump()
        end,
        desc = "Flash jump",
      },
      {
        "S",
        mode = { "n", "x", "o" },
        function()
          require("flash").treesitter()
        end,
        desc = "Flash Treesitter",
      },
      {
        "r",
        mode = "o",
        function()
          require("flash").remote()
        end,
        desc = "Remote Flash",
      },
      {
        "R",
        mode = { "o", "x" },
        function()
          require("flash").treesitter_search()
        end,
        desc = "Treesitter Search",
      },
    },
  },
}
