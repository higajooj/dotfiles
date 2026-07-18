local mainMod = "SUPER"
local modShift = mainMod .. " + SHIFT"

local function require_optional(module)
    local ok, err = pcall(require, module)
    if not ok then
        print(string.format("Optional Hyprland config module %q was not loaded: %s", module, err))
    end
end

local autostart = {
    "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP",
    "lxsession -a -s hyprland -e hyprland",
    "lxpolkit",
    "hyprpaper",
    "waybar",
    "dunst",
    "nm-applet",
    "blueman-applet",
    "solaar",
    "thunar --daemon",
    "swayidle -w",
    "warp-taskbar",
}

hl.on("hyprland.start", function()
    for _, command in ipairs(autostart) do
        hl.exec_cmd(command)
    end
end)

hl.env("XCURSOR_SIZE", "24")

-- XDG
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")

-- Electron
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")

-- Qt
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("QT_QPA_PLATFORMTHEME", "qt5ct")
hl.env("QT_QPA_PLATFORM", "wayland")

-- To manage systemd services with the Hyprland lifecycle:
-- hl.on("hyprland.start", function()
--     hl.exec_cmd("systemctl --user start hyprland-session.target")
-- end)
--
-- hl.on("hyprland.shutdown", function()
--     os.execute("systemctl --user stop hyprland-session.target && sleep 0.1")
-- end)

hl.config({
    general = {
        gaps_in = 2,
        gaps_out = 0,
        border_size = 3,
        col = {
            active_border = {
                colors = { "rgba(33ccffee)", "rgba(00ff99ee)" },
                angle = 45,
            },
            inactive_border = "rgba(595959aa)",
        },
        layout = "dwindle",
    },

    input = {
        kb_layout = "us, us_intl, br",
        kb_options = "grp:alt_shift_toggle, compose:ralt",
        repeat_delay = 300,
        follow_mouse = 1,
        touchpad = {
            natural_scroll = true,
        },
        numlock_by_default = true,
    },

    misc = {
        disable_hyprland_logo = true,
        mouse_move_enables_dpms = false,
        key_press_enables_dpms = true,
        vrr = 2,
    },

    xwayland = {
        force_zero_scaling = true,
    },

    decoration = {
        rounding = 3,
        shadow = {
            enabled = true,
            range = 4,
            render_power = 3,
            color = "rgba(1a1a1aee)",
        },
        blur = {
            enabled = true,
            size = 3,
            passes = 1,
        },
    },

    group = {
        groupbar = {
            font_family = "GeistMono Nerd Font Bold",
            font_size = 8,
            col = {
                active = "rgb(000000)",
                inactive = "rgb(333333)",
            },
            text_color = "rgb(eeeeee)",
        },
    },

    animations = {
        enabled = false,
    },

    dwindle = {
        force_split = 2,
    },

    master = {
        new_status = "master",
    },
})

hl.window_rule({
    match = { class = "imv" },
    float = true,
})

hl.window_rule({
    match = { class = "qalculate-gtk" },
    float = true,
    size = { 805, 540 },
    pin = true,
})

hl.window_rule({
    match = { class = "com.gabm.satty" },
    float = true,
    size = { 1100, 700 },
})

hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd("kitty"))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd([[rofi -combi-modes "run,drun" -show combi]]))
hl.bind(mainMod .. " + Period", hl.dsp.exec_cmd([[rofi -modi emoji -show emoji -kb-custom-1 Return -kb-accept-entry ""]]))
hl.bind(mainMod .. " + XF86Calculator", hl.dsp.exec_cmd("qalculate-gtk"))
hl.bind(mainMod .. " + Home", hl.dsp.exec_cmd("qalculate-gtk"))
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(modShift .. " + E", hl.dsp.exit())
hl.bind(modShift .. " + Space", hl.dsp.window.float())

-- Volume controls
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true })
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true })

-- Brightness controls; preserve the legacy bindlr locked + release behavior.
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("backlight_control -2"), { locked = true, release = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("backlight_control +2"), { locked = true, release = true })

-- Lock and suspend
local lockScript = (os.getenv("HOME") or "") .. "/.config/hypr/lock.sh"
hl.bind("SUPER + CTRL + SHIFT + l", hl.dsp.exec_cmd("bash " .. lockScript))
hl.bind(modShift .. " + END", hl.dsp.exec_cmd("systemctl suspend"))

local directions = {
    h = "left",
    l = "right",
    k = "up",
    j = "down",
}

for key, direction in pairs(directions) do
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ direction = direction }))
    hl.bind(modShift .. " + " .. key, hl.dsp.window.move({ direction = direction }))
end

-- Switch workspaces and move the active window with mainMod + [1-9].
for workspace = 1, 9 do
    local key = tostring(workspace)
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = workspace }))
    hl.bind(modShift .. " + " .. key, hl.dsp.window.move({ workspace = workspace }))
end

for _, key in ipairs({ "apostrophe", "grave" }) do
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = 10 }))
    hl.bind(modShift .. " + " .. key, hl.dsp.window.move({ workspace = 10 }))
end

hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen_state({
    internal = 2,
    client = 2,
    action = "toggle",
}))
hl.bind(modShift .. " + Z", hl.dsp.window.pin())

hl.bind(mainMod .. " + W", hl.dsp.group.toggle())
hl.bind(mainMod .. " + Z", hl.dsp.group.prev())
hl.bind(mainMod .. " + X", hl.dsp.group.next())
hl.bind(modShift .. " + X", hl.dsp.window.move({ out_of_group = true }))

-- Move/resize windows with mainMod + LMB/RMB and dragging.
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Screenshots
hl.bind(modShift .. " + s", hl.dsp.exec_cmd([=[screenshot_path="$HOME/Pictures/Screenshots/$(date +'%Y-%m-%d_%H-%M-%S').png" && hyprshot -m region --raw | satty --filename - --actions-on-enter save-to-clipboard --save-after-copy --copy-command 'wl-copy' --early-exit --output-filename "$screenshot_path"]=]))
hl.bind("SUPER + SHIFT + CTRL + s", hl.dsp.exec_cmd([=[screenshot_path="$HOME/Pictures/Screenshots/$(date +'%Y-%m-%d_%H-%M-%S').png" && hyprshot -m active -m output --raw | satty --filename - --actions-on-enter save-to-clipboard --save-after-copy --copy-command 'wl-copy' --early-exit --output-filename "$screenshot_path"]=]))

-- Generate and copy a UUID.
hl.bind(mainMod .. " + U", hl.dsp.exec_cmd([[uuidgen | tr -d '\n' | wl-copy]]))

require_optional("monitors")
require_optional("custom.custom")
