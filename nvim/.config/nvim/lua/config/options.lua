-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- LSP Server to use for Python.
-- Set to "basedpyright" to use basedpyright instead of pyright.
vim.g.lazyvim_python_lsp = "pyright"
-- Set to "ruff_lsp" to use the old LSP implementation version.
vim.g.lazyvim_python_ruff = "ruff"

-- In your ~/.config/nvim/lua/config/options.lua or init.lua
vim.opt.swapfile = false -- Disable swap files entirely (simple but not recommended)

-- OR better: auto-delete swap files for readonly buffers
vim.api.nvim_create_autocmd("SwapExists", {
  callback = function()
    vim.v.swapchoice = "o" -- Always open read-only if swap exists
  end,
})

return {
  {
    "LazyVim/LazyVim",
    opts = {
      options = {
        -- Set options for all buffers
        expandtab = true,
        tabstop = 4,
        softtabstop = 4,
        shiftwidth = 4,
      },
    },
  },
}
