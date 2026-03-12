return {
  "saghen/blink.cmp",
  opts = {
    keymap = {
      preset = "super-tab", -- VSCode-style: Tab accepts, arrows / C-n/C-p navigate
    },

    -- Recommended tweaks for smoother "supertab" feel (most people add these)
    completion = {
      list = {
        selection = {
          preselect = true, -- auto-highlight the first item → Tab immediately accepts it
          auto_insert = true, -- as you type more, it auto-inserts / updates the ghost text
        },
      },
    },

    -- Optional: make ghost text (inline preview) clearer or disable if distracting
    -- appearance = { use_nvim_cmp_as_default = true },  -- if your theme looks off
  },
}
