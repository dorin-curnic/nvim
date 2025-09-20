local M = {}

local is_mac = (vim.fn.has("mac") == 1) or (vim.loop.os_uname().sysname == "Darwin")

local function map(mode, lhs, rhs, desc, opts)
  opts = opts or {}
  opts.silent = opts.silent ~= false
  if desc then opts.desc = desc end
  vim.keymap.set(mode, lhs, rhs, opts)
end

-- =========
-- Globals
-- =========
function M.setup()
  -- Leader
  vim.g.mapleader = vim.g.mapleader or " "

  -- Save
  map({ "n", "i", "v", "x" }, "<C-s>", "<cmd>update<cr>", "Save")
  if is_mac then
    map({ "n", "i", "v", "x" }, "<D-s>", function()
      vim.cmd("update")
      pcall(function() vim.lsp.buf.format({ async = true }) end)
    end, "Save + Format")
  end

  -- Quit
  map("n", "<leader>q", "<cmd>q<cr>", "Quit")
  map("n", "<leader>Q", "<cmd>qa!<cr>", "Quit all")

  -- Buffers
  map("n", "<leader>bd", "<cmd>bdelete<cr>", "Delete buffer")
  map("n", "<S-l>", "<cmd>bnext<cr>",  "Next buffer")
  map("n", "<S-h>", "<cmd>bprevious<cr>", "Prev buffer")

  -- Windows / splits
  map("n", "<leader>sv", "<C-w>v", "Split vertical")
  map("n", "<leader>sh", "<C-w>s", "Split horizontal")
  map("n", "<leader>se", "<C-w>=", "Equalize splits")
  map("n", "<leader>sx", "<cmd>close<cr>", "Close split")

  -- Move lines with Alt/Option
  map("n", "<A-j>", ":m .+1<CR>==", "Move line down")
  map("n", "<A-k>", ":m .-2<CR>==", "Move line up")
  map("i", "<A-j>", "<Esc>:m .+1<CR>==gi", "Move line down")
  map("i", "<A-k>", "<Esc>:m .-2<CR>==gi", "Move line up")
  map("v", "<A-j>", ":m '>+1<CR>gv=gv", "Move selection down")
  map("v", "<A-k>", ":m '<-2<CR>gv=gv", "Move selection up")

  -- Clear search highlights fast
  map({ "n", "i" }, "<Esc>", function()
    vim.cmd.nohlsearch()
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
  end, "Clear search highlight")

  -- Terminal mode: quick exit
  map("t", "<Esc>", "<C-\\><C-n>", "Exit Terminal mode")

  -- =========
  -- Plugins
  -- =========

  -- Neo-tree (right side)
  map("n", "<leader>e", "<cmd>Neotree toggle position=right<cr>", "Toggle Explorer")
  map("n", "<leader>E", "<cmd>Neotree reveal position=right<cr>", "Reveal current file")
  if is_mac then
    map("n", "<D-b>", "<cmd>Neotree toggle position=right<cr>", "Toggle Explorer (⌘B)")
  end

  -- Telescope
  map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", "Find files")
  map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", "Live grep")
  map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", "Buffers")
  map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", "Help tags")
  if is_mac then
    map("n", "<D-p>", "<cmd>Telescope find_files<cr>", "Find files (⌘P)")
    map("n", "<D-f>", "<cmd>Telescope live_grep<cr>", "Live grep (⌘F)")
  end

  -- Comment.nvim (remap to built-in gc/gcc so plugin handles logic)
  map("n", "<leader>/", "gcc", "Toggle comment line", { remap = true })
  map("v", "<leader>/", "gc",  "Toggle comment selection", { remap = true })
  if is_mac then
    map("n", "<D-/>", "gcc", "Toggle comment line (⌘/)", { remap = true })
    map("v", "<D-/>", "gc",  "Toggle comment selection (⌘/)", { remap = true })
  end

  -- Lazy UI
  map("n", "<leader>lz", "<cmd>Lazy<cr>", "Open Lazy")
end

-- =========
-- LSP on_attach (buffer-local maps)
-- =========
function M.lsp_on_attach(_, bufnr)
  local function bmap(mode, lhs, rhs, desc, opts)
    opts = opts or {}
    opts.silent = opts.silent ~= false
    opts.buffer = bufnr
    if desc then opts.desc = desc end
    vim.keymap.set(mode, lhs, rhs, opts)
  end

  -- Basic LSP
  bmap("n", "K",  vim.lsp.buf.hover,        "LSP Hover")
  bmap("n", "gd", vim.lsp.buf.definition,   "Go to Definition")
  bmap("n", "gi", vim.lsp.buf.implementation, "Go to Implementation")
  bmap("n", "gD", vim.lsp.buf.declaration,  "Go to Declaration")
  bmap("n", "gt", vim.lsp.buf.type_definition, "Type Definition")
  bmap("n", "<leader>rn", vim.lsp.buf.rename, "Rename")
  bmap({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code Action")

  -- References via Telescope if available, else fallback
  bmap("n", "gr", function()
    local ok, tb = pcall(require, "telescope.builtin")
    if ok then tb.lsp_references({ include_declaration = false }) else vim.lsp.buf.references() end
  end, "References")

  -- Formatting
  bmap({ "n", "x" }, "<leader>f", function() vim.lsp.buf.format({ async = true }) end, "Format")

  -- Diagnostics
  bmap("n", "[d", vim.diagnostic.goto_prev, "Prev diagnostic")
  bmap("n", "]d", vim.diagnostic.goto_next, "Next diagnostic")
  bmap("n", "<leader>de", vim.diagnostic.open_float, "Line diagnostics")
  bmap("n", "<leader>dl", vim.diagnostic.setloclist, "Diagnostics → loclist")
end

return M
