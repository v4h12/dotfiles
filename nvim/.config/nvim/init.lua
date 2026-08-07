-- Options
local opt = vim.opt

opt.clipboard = "unnamedplus"
opt.number = true         -- show line numbers
opt.relativenumber = true -- relative line numbers
opt.tabstop = 4           -- tab width
opt.shiftwidth = 4        -- indent width
opt.expandtab = true      -- spaces instead of tabs
opt.smartindent = true    -- auto indent
opt.wrap = false          -- no line wrapping
opt.hlsearch = true       -- highlight when searching with '/'
opt.termguicolors = true  -- TTY only supports 16 colors - false for TTY
opt.scrolloff = 8         -- keep 8 lines above/below cursor
opt.signcolumn = "yes"    -- always show sign column 
opt.updatetime = 250      -- faster updates
opt.splitright = true     -- vertical splits go right
opt.splitbelow = true     -- horizontal splits go below
opt.cmdheight = 0

-- Keymaps
local map = vim.keymap.set

vim.g.mapleader = " "        -- space as leader key

-- mappings
map("v", "<", "<gv", { desc = "Indent left" })
map("v", ">", ">gv", { desc = "Indent right" })
map("n", "<leader>e", "<cmd>Ex<cr>", { desc = "NetRW" })
map("v", "<S-j>", ":m '>+1<cr>gv=gv", { desc = "Move selection down" })
map("v", "<S-k>", ":m '<-2<cr>gv=gv", { desc = "Move selection up" })
map("n", "<Esc>", "<cmd>nohlsearch<cr>", { desc = "Clear search highlight" })

-- splits
map("n", "<leader>wv", "<cmd>vsp<cr>",  { desc = "Split vertical" })
map("n", "<leader>ws", "<cmd>sp<cr>",   { desc = "Split horizontal" })
map("n", "<leader>wc", "<cmd>close<cr>", { desc = "Close split" })
map("n", "<C-h>", "<C-w>h", { desc = "Move to left split" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to right split" })
map("n", "<C-j>", "<C-w>j", { desc = "Move to lower split" })
map("n", "<C-k>", "<C-w>k", { desc = "Move to upper split" })

-- buffers
-- map("n", "<leader>bl", "<cmd>bnext<cr>",     { desc = "Next buffer" })
-- map("n", "<leader>bh", "<cmd>bprev<cr>",     { desc = "Prev buffer" })
-- map("n", "<leader>bc", "<cmd>bdelete<cr>",   { desc = "Delete buffer" })
map("n", "<leader>b", function()
  require("buffer_manager.ui").toggle_quick_menu()
end, { desc = "Buffer manager" })

-- LSP (these only work when LSP is attached to a file)
map("n", "<leader>ca", vim.lsp.buf.code_action,  { desc = "Code action" })
map("n", "<leader>rn", vim.lsp.buf.rename,       { desc = "Rename symbol" })
map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line diagnostics" })
map("n", "gd",         vim.lsp.buf.definition,   { desc = "Go to definition" })
map("n", "K",          vim.lsp.buf.hover,        { desc = "Hover docs" })

-- misc
map("n", "<leader>n", "<cmd>enew<cr>", { desc = "New file" })

-- LSP
vim.lsp.config['luals'] = {
    cmd = { 'lua-language-server' },
    filetypes = { 'lua' },
    root_markers = { '.luarc.json', '.git' },
    settings = { Lua = { diagnostics = { globals = { "vim" } } } }
}

vim.lsp.enable({ "pyright", "bashls", "luals" })

-- Built-in completion 
vim.opt.completeopt = "menu,menuone,noselect,popup"

-- Global border for floating windows
vim.o.winborder = "single"

-- Plugins
vim.pack.add({
  { src = "https://github.com/navarasu/onedark.nvim" },
  -- { src = "https://github.com/rebelot/kanagawa.nvim" },
  { src = "https://github.com/folke/which-key.nvim" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
  { src = "https://github.com/windwp/nvim-autopairs" },
  { src = "https://github.com/nvim-tree/nvim-web-devicons" },
  { src = "https://github.com/nvim-lualine/lualine.nvim"},
  { src = "https://github.com/nvim-lua/plenary.nvim" },
  { src = "https://github.com/j-morano/buffer_manager.nvim"},
})

-- Colorschemes
require("onedarker")
-- require("kanagawar")

-- require setups for vim.pack
require("which-key").setup()
require("nvim-autopairs").setup()
require("buffer_manager").setup()
require("evil_lualine")

