return {
  {
    "rebelot/kanagawa.nvim",
    enabled = true, --change to true/false
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
        transparent = true, -- set bg colorscheme
        dimInactive = false,
        terminalColors = true,
        colors = { -- add/modify theme and palette colors
          palette = {},
          theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
        },
        overrides = function(colors)
          return {
            LineNr = { bg = "none" },
            SignColumn = { bg = "none" },
            -- IndentBlanklineChar = { fg = "#444444" },
          }
        end,
        theme = "dragon",
        background = {
          dark = "dragon",
          light = "lotus",
        },
      })
      vim.cmd("colorscheme kanagawa")
    end,
  },
  {
    "kepano/flexoki-neovim",
    enabled = false,
    lazy = false,
    priority = 1000,
    config = function()
      require("flexoki").setup({
        compile = false,
        undercurl = true,
        commentStyle = { italic = true },
        functionStyle = {},
        keywordStyle = { italic = true },
        statementStyle = { bold = true },
        typeStyle = {},
        transparent = true, -- do not set background color
        dimInactive = false, -- dim inactive window `:h hl-NormalNC`
        terminalColors = true, -- define vim.g.terminal_color_
        colors = { -- add/modify theme and palette colors
          palette = {},
          theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
        },
        overrides = function(colors) -- add/modify highlights
          return {
            LineNr = { bg = "none" },
            SignColumn = { bg = "none" },
          }
        end,
        theme = "dragon", -- Load "dragon" theme
        background = { -- map the value of 'background' option to a theme
          dark = "flexoki-dark", -- try "dragon" !
          light = "flexoki-light",
        },
      })
      vim.cmd("colorscheme flexoki-dark")
    end,
  },
}
