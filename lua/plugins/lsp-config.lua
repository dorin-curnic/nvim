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
        "clangd",  -- C / C++
        "ts_ls",   -- JavaScript & TypeScript
        "sqlls",   -- SQL
        "jdtls",   -- Java
        "lua_ls",  -- Lua
        "html",    -- HTML
        "cssls",   -- CSS
        "bzl",     -- Bazel / Starlark LSP
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
      local capabilities = require("blink.cmp").get_lsp_capabilities()

      local servers = {
        "pyright", -- Python
        "clangd",  -- C / C++
        "ts_ls",   -- JavaScript & TypeScript
        "sqlls",   -- SQL
        "jdtls",   -- Java
        "lua_ls",  -- Lua
        "html",    -- HTML
        "cssls",   -- CSS
        "bzl",     -- Bazel/Starlark
      }

      -- Configure Mason-managed servers.
      for _, name in ipairs(servers) do
        lspconfig[name].setup({
          on_attach = on_attach,
          capabilities = capabilities,
        })
      end

      -- Swift / Xcode projects.
      -- This is NOT installed by Mason. It comes from Xcode.
      lspconfig.sourcekit.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        cmd = { "xcrun", "--toolchain", "default", "sourcekit-lsp" },
        filetypes = { "swift" },
        root_dir = function(fname)
          return lspconfig.util.root_pattern("buildServer.json")(fname)
              or lspconfig.util.root_pattern("*.xcodeproj", "*.xcworkspace", "Package.swift", ".git")(fname)
        end,
      })
    end,
  },
}
