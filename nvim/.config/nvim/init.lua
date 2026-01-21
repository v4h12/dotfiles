-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

if vim.env.ZELLIJ ~= nil then
  vim.opt.laststatus = 0
else
  vim.opt.laststatus = 2
end
