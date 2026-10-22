-- #####################
-- ### LOOK AND FEEL ###
-- #####################

-- Refer to https://wiki.hyprland.org/Configuring/Variables/

-- https://wiki.hyprland.org/Configuring/Variables/#general

hl.config({
    general = {
      gaps_in = 0,      -- 3
      gaps_out = 0,     -- 6
      border_size = 2,  -- 1 or 2

      col = {
        active_border = "#3D5566", -- this one here
        -- active_border = "#696969",
        -- inactive_border = "#1e1e1e",
        inactive_border = "#141413", -- also this one here
      },

      hover_icon_on_border = true,
      resize_on_border = true,
      allow_tearing = false,
      layout = "dwindle",

    },

    decoration = {
      rounding         = 0,
      rounding_power   = 0,

      active_opacity   = 1.0,
      inactive_opacity = 1.0,    -- 0.96

      shadow = {
        enabled = false,
        range = 4,
        render_power = 3,
        -- color = "rgba(1a1a1aee)",
        color = "#1a1a1a",

      },

    },

    animations = {
      enabled = false,

    },

})

-- curves
hl.curve("instant", {
    type = "bezier",
    points = {
        {0, 0},
        {1, 1}
    }
})

hl.curve("snap", {
    type = "bezier",
    points = {
        {0.9, 0},
        {0.1, 1}
    }
})

-- Animations
hl.animation({
    leaf = "global",
    enabled = true,
    speed = 1,
    bezier = "instant"
})

hl.animation({
    leaf = "border",
    enabled = true,
    speed = 2,
    bezier = "instant"
})

hl.animation({
    leaf = "windows",
    enabled = true,
    speed = 2,
    bezier = "snap",
    style = "slide"
})

hl.animation({
    leaf = "windowsIn",
    enabled = true,
    speed = 2,
    bezier = "snap",
    style = "popin 95%"
})

hl.animation({
    leaf = "windowsOut",
    enabled = true,
    speed = 1.5,
    bezier = "instant",
    style = "popin 98%"
})

hl.animation({
    leaf = "fadeIn",
    enabled = true,
    speed = 1.5,
    bezier = "instant"
})

hl.animation({
    leaf = "fadeOut",
    enabled = true,
    speed = 1.5,
    bezier = "instant"
})

hl.animation({
    leaf = "fade",
    enabled = true,
    speed = 1.5,
    bezier = "instant"
})

hl.animation({
    leaf = "layers",
    enabled = true,
    speed = 2,
    bezier = "instant"
})

hl.animation({
    leaf = "layersIn",
    enabled = true,
    speed = 2,
    bezier = "instant",
    style = "fade"
})

hl.animation({
    leaf = "layersOut",
    enabled = true,
    speed = 1.5,
    bezier = "instant",
    style = "fade"
})

hl.animation({
    leaf = "fadeLayersIn",
    enabled = true,
    speed = 1.5,
    bezier = "instant"
})

hl.animation({
    leaf = "fadeLayersOut",
    enabled = true,
    speed = 1.5,
    bezier = "instant"
})

hl.animation({
    leaf = "workspaces",
    enabled = true,
    speed = 2,
    bezier = "snap",
    style = "slide"
})

hl.animation({
    leaf = "workspacesIn",
    enabled = true,
    speed = 2,
    bezier = "instant",
    style = "fade"
})

hl.animation({
    leaf = "workspacesOut",
    enabled = true,
    speed = 2,
    bezier = "instant",
    style = "fade"
})
