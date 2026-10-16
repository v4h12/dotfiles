-- #################
-- ### AUTOSTART ###
-- #################

-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- Or execute your favorite apps at launch like this:

hl.on("hyprland.start", function ()
        hl.exec_cmd("/usr/lib/xdg-desktop-portal-hyprland &")
        hl.exec_cmd("/usr/lib/xdg-desktop-portal &")
        hl.exec_cmd("/usr/bin/emacs --daemon --init-directory /home/v4h/.config/emacs")
        hl.exec_cmd("wl-paste --type text --watch cliphist store")
        hl.exec_cmd("wl-paste --type image --watch cliphist store")
        hl.exec_cmd("udiskie --no-tray &")
        hl.exec_cmd("hyprpaper &")
        hl.exec_cmd("swaync &")
        hl.exec_cmd("hypridle -c ~/.config/hypr/hypridle.conf")
        hl.exec_cmd("kitty -class HeadlessKitty -single-instance -listen-on unix:/tmp/kitty-socket tail -f /dev/null")
        hl.exec_cmd("~/.config/hypr/scripts/restore-wallpaper.sh")
        -- hl.exec_cmd("hyprctl plugin load ~/.config/hyprselect/hyprselect.so")
end)
