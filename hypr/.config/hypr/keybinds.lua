
-- ###################
-- ### KEYBINDINGS ###
-- ###################

-- See https://wiki.hypr.land/Configuring/Keywords/

local mainMod = "SUPER" -- Sets "Windows" key as main modifier

-- Example binds, see https://wiki.hypr.land/Configuring/Basics/Binds/ for more

-- test for different layouts, forget about it
-- local layouts = { "dwindle", "master", "scrolling" }
-- local layout_idx = 1

-- hl.bind(mainMod .. " + Tab", function()
--     layout_idx = layout_idx % #layouts + 1
--     hl.dsp.layout(layouts[layout_idx])
-- end)

-- this creates a single instance of a kitty server, any terminals after this load fast
-- hl.bind(mainMod .. " + A", hl.dsp.exec_cmd("kitty -1", float = true))
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd("kitty -1"))
hl.bind(mainMod .. " + C", hl.dsp.exec_cmd("kitty -e cliphist list -max-items 100 | fzf | cliphist decode | wl-copy"))
hl.bind(mainMod .. " + SHIFT + Return", hl.dsp.exec_cmd("foot"))
-- dropdown terminal (Super+`): spawn once, then toggle scratchpad
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd("emacsclient -c -a 'emacs'"))
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("mailspring"))
hl.bind(mainMod .. " + SHIFT + M", hl.dsp.exec_cmd("kitty -e rmpc"))
hl.bind(mainMod .. " + ALT + M", hl.dsp.exec_cmd("./.librepods-x86_64.AppImage"))
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd("networkmanager_dmenu"))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + Y", hl.dsp.exec_cmd("freetube"))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("./.librepods-x86_64.AppImage"))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd("rofi -show drun || pkill rofi"))
hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd("~/.config/rofi/wallpaper-switcher.sh"))
hl.bind(mainMod .. " + O", hl.dsp.exec_cmd("obsidian"))
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd("zen-browser"))
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd("qutebrowser"))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + ALT + P", hl.dsp.window.pin())
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + I", hl.dsp.exec_cmd("~/.config/hypr/scripts/toggle-idle.sh"))
hl.bind(mainMod .. " + SHIFT + I", hl.dsp.exec_cmd("ie-r"))
hl.bind(mainMod .. " + ALT + I", hl.dsp.exec_cmd("pkill ie-r"))
hl.bind(mainMod .. " + ALT + J", hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + Z", hl.dsp.exec_cmd("~/.config/rofi/hyprland.sh"))
hl.bind(mainMod .. " + SHIFT + Z", hl.dsp.exec_cmd("~/.config/rofi/emacs.sh"))
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd("~/.config/hypr/scripts/toggle-waybar.sh"))
hl.bind(mainMod .. " + SHIFT + T", hl.dsp.exec_cmd("~/.config/rofi/waybar-switcher.sh"))
-- hl.bind(mainMod .. " + X", hl.dsp.exec_cmd("overview:toggle"))
hl.bind(mainMod .. " + PRINT", hl.dsp.exec_cmd("~/.config/hypr/scripts/screenie.sh"))
hl.bind(mainMod .. " + SHIFT + PRINT", hl.dsp.exec_cmd("~/.config/hypr/scripts/snippie.sh"))
hl.bind(mainMod .. " + SHIFT + Escape", hl.dsp.exit())
hl.bind(mainMod .. " + SHIFT + N", hl.dsp.exec_cmd("swaync-client -t -sw"))
hl.bind(mainMod .. " + Escape", hl.dsp.exec_cmd("hyprlock"))

-- toggle gaps
hl.bind(mainMod .. " + SHIFT + F", function()
    local gaps = hl.get_config("general.gaps_out")
    if gaps.top == 0 then
        hl.config({ general = { gaps_in = 3, gaps_out = 6 } })
    else
        hl.config({ general = { gaps_in = 0, gaps_out = 0 } })
    end
end)

-- screenshot to text tool
local OCR4Linux = "~/.config/OCR4Linux/OCR4Linux.sh"
hl.bind(mainMod .. " + ALT + Print", hl.dsp.exec_cmd(OCR4Linux .. " --lang eng"))

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

-- for i = h, l do
--   local key = i % l
--   hl.bind(mainMod .. " + " .. key,
--           hl.dsp.focus({ workspace = "e+1" }))


-- Switch workspaces with mainMod + [0-9]
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

-- hl.bind(mainMod .. " + ALT + F", hl.dsp.workspace.toggle_special("extra"))
-- hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.move({ workspace = "special:extra", follow = false }))

-- move to normal workspace
hl.bind(mainMod .. " + SHIFT + D", hl.dsp.window.move({ workspace = "e+0", follow = false }))

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

