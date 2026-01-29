return {
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("kanagawa").setup({
        compile = false,
        undercurl = true,
        commentStyle = { italic = true },
        functionStyle = {},
        keywordStyle = { italic = true },
        statementStyle = { bold = true },
        typeStyle = {},
        transparent = true,
        dimInactive = false,
        terminalColors = true,
        colors = {
          palette = {},
          theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
        },
        overrides = function(colors)
          return {
            LineNr = { bg = "none" },
            SignColumn = { bg = "none" },
            CursorLine = { bg = "none" },
            CursorLineNr = { bg = "none" },
          }
        end,
        theme = "dragon",
        background = {
          dark = "dragon",
          light = "lotus",
        },
      })
      -- ######################################### set default here ###########################################
      -- Set this as default colorscheme
      vim.cmd("colorscheme onedark")
    end,
  },
  {
    -- this bitchass theme doesnt do transparent background // so much wasted time - kill me already
    "kepano/flexoki-neovim",
    lazy = false,
    priority = 1000,
    config = function()
      require("flexoki").setup({
        transparent = true,
        overrides = function()
          return {
            Normal = { bg = "none" },
            NormalNC = { bg = "none" },
            NormalFloat = { bg = "none" },
            LineNr = { bg = "none" },
            SignColumn = { bg = "none" },
            CursorLine = { bg = "none" },
            CursorLineNr = { bg = "none" },
            StatusLine = { bg = "none" },
            StatusLineNC = { bg = "none" },
            VertSplit = { bg = "none" },
            WinSeparator = { bg = "none" },
          }
        end,
      })
    end,
  },
  {
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("gruvbox").setup({
        transparent_mode = true,
        overrides = {
          LineNr = { bg = "none" },
          SignColumn = { bg = "none" },
          CursorLine = { bg = "#191919" },
          CursorLineNr = { bg = "none" }, -- Statusline transparency
          StatusLine = { bg = "none" },
          StatusLineNC = { bg = "none" },
          VertSplit = { bg = "none" },
          WinSeparator = { bg = "none" },
          FloatBorder = { bg = "none" },
          Pmenu = { bg = "none" },
          PmenuSel = { bg = "#191919" }, -- Keep selection visible
          NeoTreeNormal = { bg = "none" },
          NeoTreeNormalNC = { bg = "none" },
          NvimTreeNormal = { bg = "none" },
          TelescopeNormal = { bg = "none" },
          TelescopeBorder = { bg = "none" },
          TelescopeSelection = { bg = "#191919" },
        },
      })
    end,
  },
  {
    "navarasu/onedark.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("onedark").setup({
        style = "dark", -- 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer'
        transparent = true,
        code_style = {
          comments = "italic",
          keywords = "italic",
          functions = "none",
          strings = "none",
          variables = "none",
        },
        colors = {},
        highlights = {
          Normal = { bg = "none" },
          NormalNC = { bg = "none" },
          NormalFloat = { bg = "none" },
          LineNr = { bg = "none" },
          SignColumn = { bg = "none" },
          CursorLine = { bg = "none" },
          CursorLineNr = { bg = "none" },
          StatusLine = { bg = "none" },
          StatusLineNC = { bg = "none" },
          VertSplit = { bg = "none" },
          WinSeparator = { bg = "none" },
        },
      })
    end,
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = false,
    priority = 1000,
    config = function()
      require("rose-pine").setup({
        variant = "main", -- 'main', 'moon', or 'dawn'
        dark_variant = "main",
        disable_background = true, -- this is their version of transparent
        styles = {
          italic = true,
          transparency = true,
        },
      })
    end,
  },
}
