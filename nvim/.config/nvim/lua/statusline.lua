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

-- evil_lualine.lua's bg. theme="auto" resolves to lualine's bundled onedark
-- theme (auto.lua:4-20) rather than reading highlight groups, so
-- transparent=true / StatusLine{bg="none"} never reach the statusline.
local statusline_bg = "#1a1a1a"

-- Only the bar background changes. a.bg keeps its per-mode color, since a.fg
-- (#282c34) on #1a1a1a would be ~1.23:1 and unreadable. insert/visual/replace/
-- command/terminal inherit normal.b/c under the bundled theme but each define
-- their own under the derived one, so loop every mode.
local function statusline_theme()
  local t = vim.deepcopy(require("lualine.themes.auto"))
  for _, mode in ipairs({ "normal", "insert", "replace", "visual", "command", "terminal", "inactive" }) do
    for _, section in ipairs({ "b", "c" }) do
      if t[mode] and t[mode][section] then
        t[mode][section].bg = statusline_bg
      end
    end
  end
  -- inactive.a is a neutral block, not a mode color; match it to the bar too.
  -- #5c6370 on #1a1a1a is ~3.03:1, which is the intended dimmed look.
  if t.inactive and t.inactive.a then
    t.inactive.a.bg = statusline_bg
  end
  return t
end

-- Neovim 0.12 fills client.progress (a vim.ringbuf) from the built-in
-- '$/progress' handler in vim/lsp/handlers.lua, so tracking it needs no
-- handler monkeypatching -- but vim.lsp.status() is unusable here:
--
--   1. It reads the ringbuf with a generic `for`, and vim.ringbuf iteration is
--      consuming: push 2, iterate -> 2, iterate again -> 0. The first lualine
--      refresh therefore eats the progress and every redraw after it gets "".
--   2. It keeps `percentage` from the last report that had one, so a stalled
--      server still shows a stale number, and it appends tostring(#clients)..'%',
--      which renders a bogus client count.
--
-- So mirror the autocmd into a plain table instead and read that.
local lsp_progress_state = {} -- [client_id] = { [token] = { title, message, percentage } }

local function lsp_track_progress()
  -- One augroup for both autocmds: create_augroup({clear=true}) wipes the group,
  -- so calling it a second time would delete the autocmd just registered.
  local group = vim.api.nvim_create_augroup("StatuslineLspProgress", { clear = true })

  vim.api.nvim_create_autocmd("LspProgress", {
    group = group,
    desc = "Feed the lualine lsp_progress component",
    callback = function(ev)
      local client_id = ev.data.client_id
      local value = ev.data.params.value
      if type(value) ~= "table" or not value.kind then
        return
      end
      local tokens = lsp_progress_state[client_id]
      if not tokens then
        tokens = {}
        lsp_progress_state[client_id] = tokens
      end
      if value.kind == "end" then
        tokens[ev.data.params.token] = nil
        return
      end
      local entry = tokens[ev.data.params.token]
      if not entry then
        entry = {}
        tokens[ev.data.params.token] = entry
      end
      if value.kind == "begin" then
        entry.title = value.title
      end
      if value.message then
        entry.message = value.message
      end
      if value.percentage then
        entry.percentage = value.percentage
      end
    end,
  })

  -- A server that exits mid-index never sends 'end', so drop its entries here
  -- rather than letting a phantom progress line stick to the bar forever.
  vim.api.nvim_create_autocmd("LspDetach", {
    group = group,
    desc = "Forget progress for clients that went away",
    callback = function(ev)
      lsp_progress_state[ev.data.client_id] = nil
    end,
  })
end

-- lualine does not escape '%' in custom component output, so do it ourselves.
local function lsp_progress()
  local labels = {}
  for _, client in ipairs(vim.lsp.get_clients()) do
    local tokens = lsp_progress_state[client.id]
    for _, entry in pairs(tokens or {}) do
      -- pyright sends title = "" for every message, so fall back to the client
      -- name; without this the bar reads ": 2 files to analyze".
      local label = (entry.title ~= "" and entry.title) or client.name or "LSP"
      if entry.message and entry.message ~= "" then
        label = label .. ": " .. entry.message
      end
      if entry.percentage then
        label = string.format("%3d%%: %s", entry.percentage, label)
      end
      table.insert(labels, label)
    end
  end
  if #labels == 0 then
    return ""
  end
  -- truncate before escaping so a cut can never land inside an escape sequence
  return (table.concat(labels, "  "):sub(1, 60):gsub("%%", "%%%%"))
end

-- Shown whenever nothing is in flight, so the right side is not blank.
-- Only pyright reports progress, and luals/bashls emit none at all.
local function lsp_clients()
  -- Yield while lsp_progress is rendering, otherwise both components show at
  -- once ("pyright  pyright").
  for _, client in ipairs(vim.lsp.get_clients()) do
    if next(lsp_progress_state[client.id] or {}) ~= nil then
      return ""
    end
  end
  local names, seen = {}, {}
  for _, client in ipairs(vim.lsp.get_clients()) do
    if not seen[client.name] then
      seen[client.name] = true
      table.insert(names, client.name)
    end
  end
  return table.concat(names, " ")
end

local function get_root()
  return vim.fs.root(0, root_markers)
end

lsp_track_progress()

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
    theme = statusline_theme,
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
      {
        lsp_progress,
        color = { fg = hl_color("DiagnosticInfo") },
        padding = { left = 1, right = 0 },
      },
      { lsp_clients, padding = { left = 1, right = 0 } },
      { "selectioncount", padding = { left = 1, right = 0 } },
      { "searchcount", padding = { left = 0, right = 1 } },
    },
  },

  extensions = { "neo-tree" },
})
