-- LazyVim's bufferline/tabline, ported to vim.pack.
-- Upstream: folke/LazyVim lua/lazyvim/plugins/ui.lua (bufferline.nvim spec)
--
-- Differences from upstream, because we have no lazy.nvim/Snacks:
--   close_command/right_mouse_command -> "bdelete! %d" (bufferline's own default)
--   get_element_icon                  -> dropped, so nvim-web-devicons is used
local bufferline = require("bufferline")

-- stylua: ignore
local icons = {
  diagnostics = { Error = "\u{f057} ", Warn = "\u{f071} " },
}

bufferline.setup({
  options = {
    close_command = "bdelete! %d",
    right_mouse_command = "bdelete! %d",
    diagnostics = "nvim_lsp",
    always_show_bufferline = false,
    diagnostics_indicator = function(_, _, diag)
      local ret = (diag.error and icons.diagnostics.Error .. diag.error .. " " or "")
        .. (diag.warning and icons.diagnostics.Warn .. diag.warning or "")
      return vim.trim(ret)
    end,
    offsets = {
      {
        filetype = "neo-tree",
        text = "Neo-tree",
        highlight = "Directory",
        text_align = "left",
      },
    },
  },
})

-- Fix bufferline when restoring a session
vim.api.nvim_create_autocmd({ "BufAdd", "BufDelete" }, {
  callback = function()
    vim.schedule(function()
      pcall(nvim_bufferline)
    end)
  end,
})
