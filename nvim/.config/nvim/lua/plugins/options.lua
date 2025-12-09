-- lua/plugins/options.lua
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
        swapfile = false,
      },
    },
  },
}
