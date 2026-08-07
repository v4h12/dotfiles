local onedark = require("onedark")

onedark.setup({
  style = "dark",
  transparent = true,
  code_style = {
    comments = "italic",
    keywords = "italic",
    functions = "none",
    strings = "none",
    variables = "none",
  },
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
    FloatBorder = { fg = "#928374", bg = "none" },
  },
})

onedark.load()
