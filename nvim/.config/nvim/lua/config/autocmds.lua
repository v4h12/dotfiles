-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- vim.api.nvim_create_autocmd("ColorScheme", {
--   callback = function()
--     local groups = {
--       "Normal",
--       "NormalNC",
--       "NormalFloat",
--       "FloatBorder",
--       "SignColumn",
--       "LineNR",
--       "CursorLineNR",
--       "StatusLine",
--       "StatusLineNC",
--     }
--
--     for _, group in ipairs(groups) do
--       vim.api.nvim_set_hl(0, group, { bg = "none" })
--     end
--   end,
-- })

-- this is dfor markdown files for writing / means word wrap around the buffer
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
    vim.opt_local.textwidth = 0
  end,
})
