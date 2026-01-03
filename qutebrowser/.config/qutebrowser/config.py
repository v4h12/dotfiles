# pylint: disable=C0111
c = c  # noqa: F821 pylint: disable=E0602,C0103
config = config  # noqa: F821 pylint: disable=E0602,C0103

# Dark color scheme
colors = {
    "bg": "#1a1a1a",  # dark background
    "bg_alt": "#252525",  # slightly lighter background
    "fg": "#e0e0e0",  # light foreground text
    "fg_dim": "#a0a0a0",  # dimmed text
    "black": "#000000",
    "red": "#ff6b6b",
    "green": "#51cf66",
    "yellow": "#ffd93d",
    "blue": "#74c0fc",
    "magenta": "#da77f2",
    "cyan": "#66d9ef",
    "white": "#f8f8f2",
    "bright_black": "#6c6c6c",
    "bright_green": "#69ff94",
    "accent": "#c34043",  # kana red
    "selection": "#44475a",  # selection background
}

# Statusbar colors
c.colors.statusbar.normal.bg = colors["bg"]
c.colors.statusbar.command.bg = colors["bg"]
c.colors.statusbar.command.fg = colors["fg"]
c.colors.statusbar.normal.fg = colors["accent"]
c.colors.statusbar.passthrough.fg = colors["cyan"]
c.colors.statusbar.url.fg = colors["accent"]
c.colors.statusbar.url.success.https.fg = colors["fg"]
c.colors.statusbar.url.hover.fg = colors["blue"]

# Tab colors
c.colors.tabs.even.bg = colors["bg"]
c.colors.tabs.odd.bg = colors["bg"]
c.colors.tabs.bar.bg = colors["bg"]
c.colors.tabs.even.fg = colors["fg_dim"]
c.colors.tabs.odd.fg = colors["fg_dim"]
c.colors.tabs.selected.even.bg = colors["bg_alt"]
c.colors.tabs.selected.odd.bg = colors["bg_alt"]
c.colors.tabs.selected.even.fg = colors["fg"]
c.colors.tabs.selected.odd.fg = colors["fg"]
c.colors.tabs.indicator.start = colors["bright_green"]
c.colors.tabs.indicator.stop = colors["bright_black"]
c.tabs.show = "multiple"

# Hints
c.colors.hints.bg = colors["accent"]
c.colors.hints.fg = colors["fg"]
c.hints.border = colors["accent"]

# Completion menu
c.colors.completion.odd.bg = colors["bg"]
c.colors.completion.even.bg = colors["bg_alt"]
c.colors.completion.fg = colors["fg"]
c.colors.completion.category.bg = colors["bg"]
c.colors.completion.category.fg = colors["accent"]
c.colors.completion.item.selected.bg = colors["selection"]
c.colors.completion.item.selected.fg = colors["fg"]
c.colors.completion.item.selected.match.fg = colors["cyan"]
c.colors.completion.match.fg = colors["cyan"]

# Messages and downloads
c.colors.messages.info.bg = colors["bg"]
c.colors.messages.info.fg = colors["fg"]
c.colors.messages.error.bg = colors["red"]
c.colors.messages.error.fg = colors["fg"]
c.colors.downloads.error.bg = colors["red"]
c.colors.downloads.error.fg = colors["fg"]
c.colors.downloads.bar.bg = colors["bg"]
c.colors.downloads.start.bg = colors["green"]
c.colors.downloads.start.fg = colors["fg"]
c.colors.downloads.stop.bg = colors["bright_black"]
c.colors.downloads.stop.fg = colors["fg"]

# Tooltips and webpage
c.colors.tooltip.bg = colors["bg"]
c.colors.webpage.bg = colors["bg"]

# Tab formatting and fonts
c.tabs.title.format = "{audio}{current_title}"
c.fonts.web.size.default = 9

# Search engines
c.url.searchengines = {
    "DEFAULT": "https://duckduckgo.com/?q={}",
    "!aw": "https://wiki.archlinux.org/?search={}",
    "!apkg": "https://archlinux.org/packages/?sort=&q={}&maintainer=&flagged=",
    "!gh": "https://github.com/search?o=desc&q={}&s=stars",
    "!yt": "https://www.youtube.com/results?search_query={}",
}

c.completion.open_categories = [
    "searchengines",
    "quickmarks",
    "bookmarks",
    "history",
    "filesystem",
]

config.load_autoconfig()  # load settings done via the gui

c.auto_save.session = True  # save tabs on quit/restart

# Keybindings
config.bind("=", "cmd-set-text -s :open")
config.bind("h", "history")
config.bind("cc", 'hint images spawn sh -c "cliphist link {hint-url}"')
config.bind("cs", "cmd-set-text -s :config-source")
config.bind("tH", "config-cycle tabs.show multiple never")
config.bind("sH", "config-cycle statusbar.show always never")
config.bind("T", "hint links tab")
config.bind("pP", "open -- {primary}")
config.bind("pp", "open -- {clipboard}")
config.bind("pt", "open -t -- {clipboard}")
config.bind("qm", "macro-record")
config.bind("<ctrl-y>", "spawn --userscript ytdl.sh")
config.bind("tT", "config-cycle tabs.position top left")
config.bind("gJ", "tab-move +")
config.bind("gK", "tab-move -")
config.bind("gm", "tab-move")


# Dark mode for websites
c.colors.webpage.darkmode.enabled = True
c.colors.webpage.darkmode.algorithm = "lightness-cielab"
c.colors.webpage.darkmode.policy.images = "never"
config.set("colors.webpage.darkmode.enabled", False, "file://*")

# Styles and cosmetics
c.tabs.padding = {"top": 3, "bottom": 3, "left": 9, "right": 9}
c.tabs.indicator.width = 0  # no tab indicators
c.tabs.width = "2%"

# Fonts
c.fonts.default_family = []
c.fonts.default_size = "9pt"
c.fonts.web.family.fixed = "monospace"
c.fonts.web.family.sans_serif = "monospace"
c.fonts.web.family.serif = "monospace"
c.fonts.web.family.standard = "monospace"

# Privacy settings
config.set("content.webgl", False, "*")
config.set("content.canvas_reading", False)
config.set("content.geolocation", False)
config.set("content.webrtc_ip_handling_policy", "default-public-interface-only")
config.set("content.cookies.accept", "all")
config.set("content.cookies.store", True)

# Adblocking
c.content.blocking.enabled = True
