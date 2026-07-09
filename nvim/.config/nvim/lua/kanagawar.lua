-- "rebelot/kanagawa.nvim",
local kanagawa = require("kanagawa")

kanagawa.setup({
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

kanagawa.load()
