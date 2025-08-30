-- lua/plugins/theme.lua
return {
  {
    "Shatur/neovim-ayu",
    -- ensure it loads before any colorscheme is set
    priority = 1000,
    config = function()
      -- set up Ayu with default dark (mirage=false)
      require("ayu").setup({
        mirage     = false,  -- false = use 'ayu-dark'; true = 'mirage' variant
        terminal   = true,   -- let Ayu apply terminal colors
        overrides  = {},     -- no overrides, blank bg/text etc
      })
      -- apply the 'dark' variant
      vim.cmd("colorscheme ayu-dark")  -- :contentReference[oaicite:0]{index=0}
    end,
  },
}
