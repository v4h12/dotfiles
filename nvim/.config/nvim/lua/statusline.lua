-- LazyVim's statusline, ported to vim.pack.
-- Upstream: folke/LazyVim lua/lazyvim/plugins/ui.lua + lua/lazyvim/util/lualine.lua
--
-- Differences from upstream, all because we have no lazy.nvim/Snacks:
--   Snacks.util.color(hl)      -> hl_color(), using vim.api.nvim_get_hl
--   LazyVim.root.get()         -> vim.fs.root(), native in 0.12
--   Snacks.bufdelete()         -> (n/a, lives in bufferline.lua)
--   Snacks.profiler/noice/dap/lazy.status/trouble -> dropped, plugins not installed
local lualine_require = require("lualine_require")
lualine_require.require = require

local lualine = require("lualine")

-- stylua: ignore
local icons = {
  diagnostics = { Error = "\u{f057} ", Warn = "\u{f071} ", Info = "\u{f05a} ", Hint = "\u{f1eb} " },
  git         = { added = "\u{f0fe} ", modified = "\u{f14b} ", removed = "\u{f146} " },
  folder      = "\u{f126d} ",
  readonly    = " \u{f033e} ",
  clock       = "\u{f43a} ",
}

local root_markers = {
  ".git",
  ".hg",
  ".svn",
  ".luarc.json",
  "package.json",
  "pyproject.toml",
  "go.mod",
  "Cargo.toml",
  "Makefile",
}

-- Snacks.util.color() replacement
local function hl_color(name)
  local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = name })
  if not ok or type(hl.fg) ~= "number" then
    return nil
  end
  return string.format("#%06x", hl.fg)
end

local function get_root()
  return vim.fs.root(0, root_markers)
end

-- port of LazyVim.lualine.format
local function format(self, text, hl_group)
  text = text:gsub("%%", "%%%%")
  if not hl_group or hl_group == "" then
    return text
  end
  self.hl_cache = self.hl_cache or {}
  local token = self.hl_cache[hl_group]
  if not token then
    local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = hl_group })
    local gui = {}
    if ok then
      if hl.bold then
        table.insert(gui, "bold")
      end
      if hl.italic then
        table.insert(gui, "italic")
      end
    end
    token = self:create_hl({
      fg = ok and type(hl.fg) == "number" and string.format("#%06x", hl.fg) or nil,
      gui = #gui > 0 and table.concat(gui, ",") or nil,
    }, "LV_" .. hl_group)
    self.hl_cache[hl_group] = token
  end
  return self:format_hl(token) .. text .. self:get_default_hl()
end

-- port of LazyVim.lualine.root_dir
local function root_dir(opts)
  opts = vim.tbl_extend("force", {
    icon = icons.folder,
    color = function()
      return { fg = hl_color("Special") }
    end,
  }, opts or {})

  local function get()
    local root = get_root()
    return root and vim.fs.basename(root) or nil
  end

  return {
    function()
      return (opts.icon and opts.icon .. " ") .. (get() or "")
    end,
    cond = function()
      return get() ~= nil
    end,
    color = opts.color,
  }
end

-- port of LazyVim.lualine.pretty_path
local function pretty_path(opts)
  opts = vim.tbl_extend("force", {
    relative = "cwd",
    modified_hl = "MatchParen",
    directory_hl = "",
    filename_hl = "Bold",
    modified_sign = "",
    readonly_icon = icons.readonly,
    length = 3,
  }, opts or {})

  return function(self)
    local path = vim.fn.expand("%:p")

    if path == "" then
      return ""
    end

    path = vim.fs.normalize(path)
    local root = get_root()
    local cwd = vim.fs.normalize(vim.uv.cwd())

    if opts.relative == "cwd" and path:find(cwd, 1, true) == 1 then
      path = path:sub(#cwd + 2)
    elseif root and path:find(root, 1, true) == 1 then
      path = path:sub(#root + 2)
    end

    local sep = package.config:sub(1, 1)
    local parts = vim.split(path, "[\\/]")

    if opts.length == 0 then
      parts = parts
    elseif #parts > opts.length then
      parts = { parts[1], "…", unpack(parts, #parts - opts.length + 2, #parts) }
    end

    if opts.modified_hl and vim.bo.modified then
      parts[#parts] = parts[#parts] .. opts.modified_sign
      parts[#parts] = format(self, parts[#parts], opts.modified_hl)
    else
      parts[#parts] = format(self, parts[#parts], opts.filename_hl)
    end

    local dir = ""
    if #parts > 1 then
      dir = table.concat({ unpack(parts, 1, #parts - 1) }, sep)
      dir = format(self, dir .. sep, opts.directory_hl)
    end

    local readonly = ""
    if vim.bo.readonly then
      readonly = format(self, opts.readonly_icon, opts.modified_hl)
    end
    return dir .. parts[#parts] .. readonly
  end
end

lualine.setup({
  options = {
    theme = "auto",
    globalstatus = vim.o.laststatus == 3,
    disabled_filetypes = { statusline = { "statusline", "alpha", "ministarter" } },
  },

  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch" },

    lualine_c = {
      root_dir(),
      {
        "diagnostics",
        symbols = {
          error = icons.diagnostics.Error,
          warn = icons.diagnostics.Warn,
          info = icons.diagnostics.Info,
          hint = icons.diagnostics.Hint,
        },
      },
      { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
      pretty_path(),
    },

    lualine_x = {
      {
        "diff",
        symbols = {
          added = icons.git.added,
          modified = icons.git.modified,
          removed = icons.git.removed,
        },
        source = function()
          local gitsigns = vim.b.gitsigns_status_dict
          if gitsigns then
            return {
              added = gitsigns.added,
              modified = gitsigns.changed,
              removed = gitsigns.removed,
            }
          end
        end,
      },
    },

    lualine_y = {
      { "progress", separator = " ", padding = { left = 1, right = 0 } },
      { "location", padding = { left = 0, right = 1 } },
    },

    lualine_z = {
      function()
        return icons.clock .. os.date("%R")
      end,
    },
  },

  extensions = { "neo-tree" },
})
