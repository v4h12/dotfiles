-- ################
-- ### MONITORS ###
-- ################
-- See https://wiki.hypr.land/Configuring/Monitors/
-- hl.monitor({ output = "", mode = "preferred", position = "auto", scale = "auto" })

-- Tag whatever isn't in use

-- -- default for 1440 monitor dual setup
-- hl.monitor({ output = "eDP-1",
--              mode = "1366x768@60",
--              position = "0x1440",
--              scale = 1
-- })

-- -- default for 1080 Monitor for dual setup
hl.monitor({ output = "eDP-1",
             mode = "1366x768@60",
             position = "0x1080",
             scale = 1
})

-- 1440 Monitor for 60hz
-- hl.monitor({ output = "HDMI-A-1",
--              mode = "2560x1440@60",
--              position = "0x0",
--              scale = 1
-- })

-- -- 1080 Monitor for 120hz
-- hl.monitor({ output = "HDMI-A-1",
--              mode = "1920x1080@120",
--              position = "0x0",
--              scale = 1
-- })

-- 1080 Monitor for 60hz
hl.monitor({ output = "HDMI-A-1",
             mode = "1920x1080@60",
             position = "0x0",
             scale = 1
})

-- unscale XWayland
hl.config({
    xwayland = {
        force_zero_scaling = true,
    },
})
