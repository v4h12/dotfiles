-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<leader>K", function()
  local word = vim.fn.expand("<cword>")
  vim.cmd("Man " .. word)
end, { desc = "Open man page" })
