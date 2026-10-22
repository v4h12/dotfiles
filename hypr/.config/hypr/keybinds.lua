
-- ###################
-- ### KEYBINDINGS ###
-- ###################

-- See https://wiki.hypr.land/Configuring/Keywords/
local mainMod = "SUPER" -- Sets "Windows" key as main modifier

-- Example binds, see https://wiki.hypr.land/Configuring/Basics/Binds/ for more
-- General Keybinds
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd("kitty -1"))
hl.bind(mainMod .. " + SHIFT + Return", hl.dsp.exec_cmd("kitty -1 --class kitty-float"))
hl.bind(mainMod .. " + ALT + Return", hl.dsp.exec_cmd("~/.config/rofi/lmux.sh"))
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd("zen-browser"))
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd("qutebrowser"))
hl.bind(mainMod .. " + SHIFT + A", hl.dsp.exec_cmd("foot"))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd("emacsclient -c -a 'emacs'"))
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("mailspring"))
hl.bind(mainMod .. " + SHIFT + M", hl.dsp.exec_cmd("kitty -e rmpc"))
hl.bind(mainMod .. " + ALT + M", hl.dsp.exec_cmd("./.librepods-x86_64.AppImage"))
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd("networkmanager_dmenu"))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + O", hl.dsp.exec_cmd("rofi -show drun || pkill rofi"))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd("~/.config/hypr/scripts/toggle-waybar.sh"))
hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd("~/.config/rofi/waybar-switcher.sh"))
hl.bind(mainMod .. " + ALT + R", hl.dsp.exec_cmd("~/.config/rofi/wallpaper-switcher.sh"))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + ALT + P", hl.dsp.window.pin())
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + I", hl.dsp.exec_cmd("~/.config/hypr/scripts/toggle-idle.sh"))
hl.bind(mainMod .. " + SHIFT + I", hl.dsp.exec_cmd("ie-r"))
hl.bind(mainMod .. " + ALT + I", hl.dsp.exec_cmd("pkill ie-r"))
hl.bind(mainMod .. " + ALT + N", hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + Z", hl.dsp.exec_cmd("~/.config/rofi/hyprland.sh"))
hl.bind(mainMod .. " + SHIFT + Z", hl.dsp.exec_cmd("~/.config/rofi/emacs.sh"))
hl.bind(mainMod .. " + PRINT", hl.dsp.exec_cmd("~/.config/hypr/scripts/screenie.sh"))
hl.bind(mainMod .. " + SHIFT + PRINT", hl.dsp.exec_cmd("~/.config/hypr/scripts/snippie.sh"))
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd("swaync-client -t -sw"))
hl.bind(mainMod .. " + Escape", hl.dsp.exec_cmd("hyprlock"))
hl.bind(mainMod .. " + SHIFT + Escape", hl.dsp.exit())

-- screenshot to text tool
local OCR4Linux = "~/.config/OCR4Linux/OCR4Linux.sh"
hl.bind(mainMod .. " + ALT + Print", hl.dsp.exec_cmd(OCR4Linux .. " --lang eng && notify-send 'OCR' 'Activated'"))

-- mpc (music)
hl.bind(mainMod .. " + ALT + up", hl.dsp.exec_cmd("mpc toggle"))
hl.bind(mainMod .. " + ALT + down", hl.dsp.exec_cmd("mpc seek 0%"))
hl.bind(mainMod .. " + ALT + left", hl.dsp.exec_cmd("mpc prev && .config/hypr/scripts/mpc-status.sh"))
hl.bind(mainMod .. " + ALT + right", hl.dsp.exec_cmd("mpc next && .config/hypr/scripts/mpc-status.sh"))

hl.bind(mainMod .. " + SHIFT + ALT + up", hl.dsp.exec_cmd(".config/hypr/scripts/mpc-status.sh"))
hl.bind(mainMod .. " + SHIFT + ALT + down", hl.dsp.exec_cmd("mpc repeat"))
hl.bind(mainMod .. " + SHIFT + ALT + left", hl.dsp.exec_cmd("mpc seek -5"))
hl.bind(mainMod .. " + SHIFT + ALT + right", hl.dsp.exec_cmd("mpc seek +5"))

-- toggle gaps
hl.bind(mainMod .. " + SHIFT + F", function()
    local gaps = hl.get_config("general.gaps_out")
    if gaps.top == 0 then
        hl.config({ general = { gaps_in = 3, gaps_out = 6 } })
    else
        hl.config({ general = { gaps_in = 0, gaps_out = 0 } })
    end
end)

-- ineffiecient but works for now, dont know lua too well sorry
hl.bind(mainMod .. " + ALT+ F", function()
    local gaps = hl.get_config("general.gaps_out")
    if gaps.top == 0 then
        hl.config({ general = { gaps_in = 0, gaps_out = 6 } })
    else
        hl.config({ general = { gaps_in = 0, gaps_out = 0 } })
    end
end)

-- Move focus with mainMod + vim keys
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))

-- vim binds
hl.bind(mainMod .. " + ALT + H", hl.dsp.window.swap({ direction = "left" }))
hl.bind(mainMod .. " + ALT + L", hl.dsp.window.swap({ direction = "right" }))
hl.bind(mainMod .. " + ALT + K", hl.dsp.window.swap({ direction = "up" }))
hl.bind(mainMod .. " + ALT + J", hl.dsp.window.swap({ direction = "down" }))

hl.bind(mainMod .. " + SHIFT + H", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.focus({ workspace = "e+1" }))

-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key,
            hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key,
            hl.dsp.window.move({ workspace = i, follow = false }))
end

-- special workspaces
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic", follow = false }))
hl.bind(mainMod .. " + ALT + S", hl.dsp.window.move({ workspace = "e+0", follow = false }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Resize windows with mainMod + SHIFT + arrow keys
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.resize({ x = 40,  y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + left",  hl.dsp.window.resize({ x = -40, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + up",    hl.dsp.window.resize({ x = 0,   y = -40, relative = true }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + down",  hl.dsp.window.resize({ x = 0,   y = 40, relative = true }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + space",  hl.dsp.window.resize({ x = 75,   y = 40, relative = true }), { repeating = true })
hl.bind(mainMod .. " + ALT + space",  hl.dsp.window.resize({ x = -75,   y = -40, relative = true }), { repeating = true })


-- Toggle the active workspace between the tiled 3-pane layout and dwindle
hl.bind(mainMod .. " + SHIFT + ALT + F", function()
    local ws = hl.get_active_workspace()
    if not ws then return end

    -- already 3-pane -> hand the workspace back to dwindle
    if ws.tiled_layout == "lua:threepane" then
        hl.workspace_rule({ workspace = tostring(ws.id), layout = "dwindle" })
        return
    end

    -- only snap on exactly 3 windows
    local wins = ws:get_windows()
    if #wins ~= 3 then return end

    for _, w in ipairs(wins) do
        hl.dispatch(hl.dsp.window.fullscreen({ action = "unset", window = w }))
        if w.floating then
            hl.dispatch(hl.dsp.window.float({ action = "unset", window = "address:" .. w.address }))
        end
    end

    hl.workspace_rule({ workspace = tostring(ws.id), layout = "lua:threepane" })
end)


-- Snap/toggle focused window to pseudo geometry (1058x738, centered)
local SNAP_W, SNAP_H = 1058, 738

hl.bind(mainMod .. " + SHIFT + P", function()
    local w = hl.get_active_window()
    if not w then return end

    local sel = "address:" .. w.address
    local s = w.size
    local snapped = w.fullscreen == 0 and not w.floating
        and math.abs(s.x - SNAP_W) <= 2 and math.abs(s.y - SNAP_H) <= 2

    if snapped then
        hl.dispatch(hl.dsp.window.pseudo({ action = "disable", window = sel }))
        return
    end

    hl.dispatch(hl.dsp.window.fullscreen({ action = "unset", window = sel }))
    if w.floating then
        hl.dispatch(hl.dsp.window.float({ action = "disable", window = sel }))
    end

    hl.dispatch(hl.dsp.window.pseudo({ action = "enable", window = sel }))
    hl.dispatch(hl.dsp.window.resize({ x = SNAP_W, y = SNAP_H, window = sel }))
end)

-- Scrolling layout to dwindle toggle
hl.bind(mainMod .. " + SPACE", function()
          local ws = hl.get_active_workspace()
          if not ws then return end
          local next = ws.tiled_layout == "scrolling" and "dwindle" or "scrolling"
          hl.workspace_rule({ workspace = tostring(ws.id), layout = next })
    end)

hl.bind(mainMod .. " + period", hl.dsp.layout("move +col"))                     -- push tape right one column
hl.bind(mainMod .. " + comma",  hl.dsp.layout("move -col"))                     -- push tape left one column
hl.bind(mainMod .. " + bracketright", hl.dsp.layout("focus r"))                 -- scroll to next column (wraps)
hl.bind(mainMod .. " + bracketleft",  hl.dsp.layout("focus l"))                 -- previous column
hl.bind(mainMod .. " + SHIFT + bracketright", hl.dsp.layout("colresize +conf")) -- cycle wider
hl.bind(mainMod .. " + SHIFT + bracketleft",  hl.dsp.layout("colresize -conf")) -- cycle narrower
hl.bind(mainMod .. " + backslash", hl.dsp.layout("fit visible"))                -- fit all visible columns
hl.bind(mainMod .. " + apostrophe", hl.dsp.layout("swapcol r"))
hl.bind(mainMod .. " + semicolon",  hl.dsp.layout("swapcol l"))


-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume",  hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),   { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume",  hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),        { locked = true, repeating = true })
hl.bind("XF86AudioMute",         hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),       { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",      hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                   { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),        { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"),  { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"),  { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),    { locked = true })

