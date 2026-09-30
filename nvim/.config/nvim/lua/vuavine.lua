local lualine = require('lualine')

local colors = {
  bg       = '#1a1a1a',
  fg       = '#abb2bf',
  red      = '#e86671',
  green    = '#98c379',
  yellow   = '#e5c07b',
  blue     = '#61afef',
  purple   = '#c678dd',
  cyan     = '#56b6c2',
  darkgrey = '#5c6370',
  orange   = '#d19a66',
}

-- Mode colors
local mode_colors = {
  n      = colors.yellow,
  i      = colors.green,
  v      = colors.blue,
  [''] = colors.blue,
  V      = colors.blue,
  c      = colors.purple,
  no     = colors.red,
  s      = colors.orange,
  S      = colors.orange,
  [''] = colors.orange,
  ic     = colors.green,
  R      = colors.red,
  Rv     = colors.red,
  cv     = colors.red,
  ce     = colors.red,
  r      = colors.cyan,
  rm     = colors.cyan,
  ['r?'] = colors.cyan,
  ['!']  = colors.red,
  t      = colors.red,
}

local function get_mode_color()
  return {
    fg = mode_colors[vim.fn.mode()] or colors.yellow,
    gui = 'bold',
  }
end

-- Return the LSP clients attached to the current buffer
local function get_lsp()
  local clients = vim.lsp.get_clients({ bufnr = 0 })

  if #clients == 0 then
    return 'No LSP'
  end

  local names = {}

  for _, client in ipairs(clients) do
    table.insert(names, client.name)
  end

  table.sort(names)

  return table.concat(names, ', ')
end

local config = {
  options = {
    theme = {
      normal = {
        a = { fg = colors.yellow, bg = colors.bg, gui = 'bold' },
        b = { fg = colors.fg, bg = colors.bg },
        c = { fg = colors.fg, bg = colors.bg },
      },
      insert = {
        a = { fg = colors.green, bg = colors.bg, gui = 'bold' },
        b = { fg = colors.fg, bg = colors.bg },
        c = { fg = colors.fg, bg = colors.bg },
      },
      visual = {
        a = { fg = colors.blue, bg = colors.bg, gui = 'bold' },
        b = { fg = colors.fg, bg = colors.bg },
        c = { fg = colors.fg, bg = colors.bg },
      },
      replace = {
        a = { fg = colors.red, bg = colors.bg, gui = 'bold' },
        b = { fg = colors.fg, bg = colors.bg },
        c = { fg = colors.fg, bg = colors.bg },
      },
      command = {
        a = { fg = colors.purple, bg = colors.bg, gui = 'bold' },
        b = { fg = colors.fg, bg = colors.bg },
        c = { fg = colors.fg, bg = colors.bg },
      },
      inactive = {
        a = { fg = colors.darkgrey, bg = colors.bg },
        b = { fg = colors.fg, bg = colors.bg },
        c = { fg = colors.fg, bg = colors.bg },
      },
    },

    component_separators = '',
    section_separators = '',
    globalstatus = true,

    refresh = {
      statusline = 1000,
    },
  },

  sections = {
    lualine_a = {},
    lualine_b = {},

    -- LEFT SIDE
    lualine_c = {
      -- Left accent
      {
        function()
          return '▌'
        end,
        color = { fg = colors.yellow },
        padding = { left = 0, right = 1 },
      },

      -- Mode
      {
        'mode',
        fmt = function(str)
          return str:upper()
        end,
        color = get_mode_color,
        padding = { left = 0, right = 1 },
      },

      -- Cursor position
      {
        'location',
        color = { fg = colors.cyan, gui = 'bold' },
        padding = { left = 1, right = 1 },
      },

      -- Filename
      {
        'filename',
        path = 0,
        symbols = {
          modified = '[+]',
          readonly = '[RO]',
          unnamed = '[No Name]',
          newfile = '[New]',
        },
        color = { fg = colors.yellow, gui = 'bold' },
        padding = { left = 1, right = 1 },
      },

      -- Diagnostics
      {
        'diagnostics',
        sources = { 'nvim_diagnostic' },
        symbols = {
          error = ' ',
          warn = ' ',
          info = ' ',
          hint = '󰌵 ',
        },
        diagnostics_color = {
          error = { fg = colors.red, gui = 'bold' },
          warn = { fg = colors.orange, gui = 'bold' },
          info = { fg = colors.cyan },
          hint = { fg = colors.blue },
        },
        update_in_insert = false,
        always_visible = false,
        padding = { left = 1, right = 1 },
      },

      -- Push the remaining components toward the middle
      {
        function()
          return '%='
        end,
      },

      -- Active LSP
      {
        function()
          return get_lsp()
        end,
        icon = '',
        color = { fg = colors.green, gui = 'bold' },
        padding = { left = 1, right = 1 },
      },
    },

    -- RIGHT SIDE
    lualine_x = {
      -- Git diff
      {
        'diff',
        symbols = {
          added = ' ',
          modified = '󰝤 ',
          removed = ' ',
        },
        diff_color = {
          added = { fg = colors.green, gui = 'bold' },
          modified = { fg = colors.orange, gui = 'bold' },
          removed = { fg = colors.red, gui = 'bold' },
        },
        source = nil,
        padding = { left = 1, right = 1 },
      },

      -- Filetype icon
      {
        'filetype',
        icon_only = true,
        colored = true,
        padding = { left = 1, right = 0 },
      },

      -- File encoding
      {
        'o:encoding',
        fmt = string.upper,
        color = { fg = colors.green, gui = 'bold' },
        padding = { left = 1, right = 1 },
      },

      -- File format (UNIX / DOS)
      {
        'fileformat',
        fmt = string.upper,
        icons_enabled = false,
        color = { fg = colors.darkgrey },
        padding = { left = 0, right = 1 },
      },

      -- Percentage through file
      {
        'progress',
        color = { fg = colors.fg, gui = 'bold' },
        padding = { left = 1, right = 1 },
      },

      -- Git branch
      {
        'branch',
        icon = '',
        color = { fg = colors.purple, gui = 'bold' },
        padding = { left = 1, right = 1 },
      },

      -- Right accent
      {
        function()
          return '▌'
        end,
        color = { fg = colors.yellow },
        padding = { left = 1, right = 0 },
      },
    },

    lualine_y = {},
    lualine_z = {},
  },

  inactive_sections = {
    lualine_a = {},
    lualine_b = {},

    lualine_c = {
      {
        function()
          return '▌'
        end,
        color = { fg = colors.darkgrey },
        padding = { left = 0, right = 1 },
      },
      {
        'filename',
        path = 0,
        color = { fg = colors.fg, gui = 'bold' },
      },
    },

    lualine_x = {
      {
        'location',
        color = { fg = colors.darkgrey },
      },
    },

    lualine_y = {},
    lualine_z = {},
  },
}

lualine.setup(config)
