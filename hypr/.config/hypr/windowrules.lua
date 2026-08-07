-- ##############################
-- ### WINDOWS AND WORKSPACES ###
-- ##############################

-- See https://wiki.hypr.land/Configuring/Window-Rules/ for more
-- See https://wiki.hypr.land/Configuring/Workspace-Rules/ for workspace rules
-- Ref https://wiki.hypr.land/Configuring/Workspace-Rules/

-- "Smart gaps" / "No gaps when only"



-- start kitty faster
hl.window_rule({
    name = "windowrule-1",
    workspace = "special:headless silent",
    match = { class = "HeadlessKitty" },
})

hl.window_rule({
    name = "pin-browser",
    workspace = "1",
    match = { class = "qutebrowser"  },
})

hl.window_rule({
    name = "pin-emacs",
    workspace = "2",
    match = { class = "emacs"  },

})
hl.window_rule({
    name = "pin-term",
    workspace = "3",
    match = { class = "kitty -1"  },
})

-- ignore maximise requests
hl.window_rule({
    name = "windowrule-2",
    suppress_event = "maximize",
    match = { class = ".*" },
})

-- Fix some dragging issues with XWayland
hl.window_rule({
    name = "windowrule-3",
    no_focus = true,
    match = {
        class = "^$",
        title = "^$",
        xwayland = true,
        float = true,
        fullscreen = false,
        pin = false,
    },
})

-- misc
-- hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
-- hl.workspace_rule({ workspace = "f[1]",   gaps_out = 0, gaps_in = 0 })
-- hl.window_rule({ name = "pseudo-all", pseudo = true, match = { class = ".*" } })
hl.window_rule({
    name = "windowrule-4",
    border_size = 0,
    rounding = 0,
    match = { float = false, workspace = "w[tv1]" },
})

hl.window_rule({
    name = "windowrule-5",
    border_size = 0,
    rounding = 0,
    match = { float = false, workspace = "f[1]" },
})

-- hl.window_rule({ name = "zathura-side", size = "50% 100%", move = "50% 0", match = { class = "^(org.pwmt.zathura)$" } })

-- floats
hl.window_rule({
    name = "windowrule-6",
    float = true,
    size = "500 500",
    center = true,
    match = { class = "^(kitty)$" },
})

hl.window_rule({
    name = "windowrule-67",
    -- float = true,
    size = "500 500",
    center = true,
    match = { class = "^(foot)$" },
})

hl.window_rule({
    name = "windowrule-7",
    float = true,
    match = { class = "^(galculator)$", title = "^(galculator)" },
})

hl.window_rule({
    name = "windowrule-8",
    float = true,
    match = { class = "^(org.pwmt.zathura)$" },
})

hl.window_rule({
    name = "windowrule-9",
    float = true,
    match = { class = "^(Artha)$", title = [[^(Artha\~\The\Open\Thesaurus)]] },
})

hl.window_rule({
    name = "windowrule-10",
    float = false,
    match = { class = "^(org%.pulseaudio%.pavucontrol)" },
})

hl.window_rule({
    name = "windowrule-11",
    float = true,
    -- opacity = "0.9 0.9",
    match = { class = "^(org%.gnome%.PowerStats)" },
})

hl.window_rule({
    name = "windowrule-12",
    float = false,
    match = { class = "^(blueman-manager)" },
})

hl.window_rule({
    name = "windowrule-13",
    float = true,
    match = { class = "^(nm-connection-editor)" },
})

hl.window_rule({
    name = "windowrule-69",
    float = true,
    center = true,
    size = "500 400",
    match = { class = "^(feh)" },
})

-- opacity
hl.window_rule({
    name = "windowrule-14",
    -- opacity = { active = 1, inactive = 1 },
    match = { class = "^(zen-browser)$" },
})

hl.window_rule({
    name = "windowrule-15",
    -- opacity = { active = 0.8, inactive = 0.8 },
    match = { class = "^(Artha)$" },
})

hl.window_rule({
    name = "windowrule-16",
    -- opacity = { active = 0.9, inactive = 0.9 },
    match = { class = "^(org%.pulseaudio%.pavucontrol)$" },
})

hl.window_rule({
    name = "windowrule-17",
    -- opacity = { active = 0.9, inactive = 0.9 },
    match = { class = "^(nm-connection-editor)$" },
})

hl.window_rule({
    name = "windowrule-18",
    -- opacity = { active = 0.8, inactive = 0.8 },
    match = { class = "^(blueman-manager)$" },
})

hl.window_rule({
    name = "windowrule-19",
    -- opacity = { active = 0.7, inactive = 0.7 },
    match = { class = "^(micro)$" },
})

hl.window_rule({
    name = "windowrule-20",
    -- opacity = { active = 0.7, inactive = 0.7 },
    match = { class = "^(btop)$" },
})

hl.window_rule({
    name = "windowrule-21",
    -- opacity = { active = 0.7, inactive = 0.7 },
    match = { class = "^(rofi)$" },
})

-- size
hl.window_rule({
    name = "windowrule-22",
    size = "500 600",
    center = true,
    match = { class = "^(foot)$", title = "^(foot)$" },
})

hl.window_rule({
    name = "windowrule-23",
    size = "500 600",
    match = { class = [[^(Artha\~\The\Open\Thesaurus)$]], title = [[^(Artha\~\The\Open\Thesaurus)$]] },
})

hl.window_rule({
    name = "windowrule-24",
    size = "500 600",
    match = { class = "^(org%.pulseaudio%.pavucontrol)$", title = "^(org%.pulseaudio%.pavucontrol)$" },
})

-- location
hl.window_rule({
    name = "windowrule-25",
    -- opacity = { active = 1, override = true },
    dim_around = 0,
    match = { class = "^(com.github.johnfactotum.Foliate)$" },
})
-- hl.window_rule({ name = "foliate-blur", blur = true, match = { class = "^(com.github.johnfactotum.Foliate)$" } })
