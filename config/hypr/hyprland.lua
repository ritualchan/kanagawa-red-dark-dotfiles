local EMOJI_PICKER      = "~/.local/bin/emoji-picker.sh"
local WALLPAPER_DAEMON  = "awww-daemon"
local CLIPBOARD_MANAGER = "cliphist list | fuzzel --dmenu --with-nth 2 | cliphist decode | wl-copy"
local COLOR_PICKER      = "hyprpicker -a"
local CLIPBOARD         = "wl-paste --type text --watch cliphist store & wl-paste --type image --watch cliphist store"
local SCREENSHOT        = "hyprshot"
local FILE_MANAGER      = "nautilus"
local MESSENGER         = "Telegram"
local TERMINAL          = "kitty"
local BROWSER           = "prime-run librewolf"
local RUNNER            = "fuzzel"
local NOTES             = "obsidian"
local BAR               = "waybar"
local IDE               = "code"
local POLKITAGENT       = "systemctl --user start hyprpolkitagent"
local NOTIFICATIONS     = "swaync"

hl.monitor({
    output = "eDP-1",
    mode = "1920x1080@144",
    position = "0x0",
    scale = 1,
})

hl.on("hyprland.start", function ()
    hl.exec_cmd(CLIPBOARD)
    hl.exec_cmd(BAR)
    hl.exec_cmd(WALLPAPER_DAEMON)
    hl.exec_cmd(NOTIFICATIONS)
    hl.exec_cmd(POLKITAGENT)
    hl.exec_cmd(BROWSER,   { workspace = "1 silent"})
    hl.exec_cmd(IDE,       { workspace = "2 silent"})
    hl.exec_cmd(TERMINAL,  { workspace = "3 silent"})
    hl.exec_cmd(NOTES,     { workspace = "4 silent"})
    hl.exec_cmd(MESSENGER, { workspace = "5 silent"})
end)

hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("GDK_BACKEND", "wayland,x11,*")
hl.env("SDL_VIDEODRIVER", "wayland")
hl.env("CLUTTER_BACKEND", "wayland")
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("XCURSOR_SIZE", "20")
hl.env("XCURSOR_THEME", "Bibata-Modern-Classic")
hl.env("GTK_THEME", "Kanagawa-Red-Dark-Dragon")
hl.env("HYPRSHOT_DIR", "/home/ritualchan/Pictures/Screenshots")

hl.config({
    general = {
        gaps_in  = 3,
        gaps_out = 6,
        border_size = 0,

        col = {
            active_border = "rgb(33ccff)",
            inactive_border = "rgb(458588)",
        },

        resize_on_border = false,
        allow_tearing = false,
        layout = "dwindle",
    },

    decoration = {
        rounding = 0,
        rounding_power = 1,
        active_opacity = 1.0,
        inactive_opacity = 1.0,
        shadow = {
            enabled = false,
        },
        blur = {
            enabled = false,
        },
    },

    animations = {
        enabled = false,
    },

    ecosystem = {
        enforce_permissions = false,
    },

    dwindle = {
        preserve_split = true,
    },

    master = {
        new_status = "master",
    },

    scrolling = {
        fullscreen_on_one_column = true,
    },

    misc = {
        force_default_wallpaper = -1,
        disable_hyprland_logo   = false,
    },

    input = {
        kb_layout  = "us, ru",
        kb_variant = "",
        kb_model   = "",
        kb_options = "grp:win_space_toggle",
        kb_rules   = "",
        follow_mouse = 1,
        sensitivity  = 0,
 
        touchpad = {
            natural_scroll = false,
        },
    },
})

hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace"
})

hl.device({
    name = "epic-mouse-v1",
    sensitivity = -0.5,
})

hl.curve("easeOutQuint",   { type = "bezier", points = { {0.23, 1},    {0.32, 1}    } })
hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1}    } })
hl.curve("linear",         { type = "bezier", points = { {0, 0},       {1, 1}       } })
hl.curve("almostLinear",   { type = "bezier", points = { {0.5, 0.5},   {0.75, 1}    } })
hl.curve("quick",          { type = "bezier", points = { {0.15, 0},    {0.1, 1}     } })
hl.curve("easy",           { type = "spring", mass = 1, stiffness = 238.1191, dampening = 24.21279333 })

hl.animation({ leaf = "global",        enabled = true,  speed = 10,   bezier = "default" })
hl.animation({ leaf = "border",        enabled = true,  speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows",       enabled = true,  speed = 4.79, spring = "easy" })
hl.animation({ leaf = "windowsIn",     enabled = true,  speed = 4.1,  spring = "easy",         style = "popin 87%" })
hl.animation({ leaf = "windowsOut",    enabled = true,  speed = 1.49, bezier = "linear",       style = "popin 87%" })
hl.animation({ leaf = "fadeIn",        enabled = true,  speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut",       enabled = true,  speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade",          enabled = true,  speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers",        enabled = true,  speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn",      enabled = true,  speed = 4,    bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut",     enabled = true,  speed = 1.5,  bezier = "linear",       style = "fade" })
hl.animation({ leaf = "fadeLayersIn",  enabled = true,  speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true,  speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces",    enabled = true,  speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn",  enabled = true,  speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true,  speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "zoomFactor",    enabled = true,  speed = 7,    bezier = "quick" })

hl.bind("SUPER + Return",  hl.dsp.exec_cmd(TERMINAL))
hl.bind("SUPER + code:60", hl.dsp.exec_cmd(EMOJI_PICKER))
hl.bind("SUPER + E",       hl.dsp.exec_cmd(FILE_MANAGER))
hl.bind("SUPER + R",       hl.dsp.exec_cmd(RUNNER))
hl.bind("SUPER + W",       hl.dsp.exec_cmd(BROWSER))
hl.bind("SUPER + V",       hl.dsp.exec_cmd(CLIPBOARD_MANAGER))
hl.bind("SUPER + C",       hl.dsp.window.close())
hl.bind("SUPER + M",       hl.dsp.exec_cmd("hyprctl dispatch 'hl.dsp.exit()'"))
hl.bind("ALT + F4",        hl.dsp.exec_cmd("hyprctl dispatch 'hl.dsp.exit()'"))
hl.bind("SUPER + F",       hl.dsp.window.float({ action = "toggle" }))
hl.bind("SUPER + G",       hl.dsp.layout("togglesplit"))

hl.bind("PRINT", hl.dsp.exec_cmd(SCREENSHOT .. " -m output"))

hl.bind("SUPER + SHIFT + S", hl.dsp.exec_cmd(SCREENSHOT .. " -m region"))
hl.bind("SUPER + SHIFT + C", hl.dsp.exec_cmd(COLOR_PICKER))

hl.bind("SUPER + LEFT",  hl.dsp.focus({ direction = "left" }))
hl.bind("SUPER + RIGHT", hl.dsp.focus({ direction = "right" }))
hl.bind("SUPER + UP",    hl.dsp.focus({ direction = "up" }))
hl.bind("SUPER + DOWN",  hl.dsp.focus({ direction = "down" }))

hl.bind("SUPER + CTRL + LEFT",  hl.dsp.window.resize({ x = -50, y = 0, relative = true }), { repeating = true })
hl.bind("SUPER + CTRL + RIGHT", hl.dsp.window.resize({ x = 50,  y = 0, relative = true }), { repeating = true })
hl.bind("SUPER + CTRL + UP",    hl.dsp.window.resize({ x = 0, y = -50, relative = true }), { repeating = true })
hl.bind("SUPER + CTRL + DOWN",  hl.dsp.window.resize({ x = 0, y = 50,  relative = true }), { repeating = true })

hl.bind("SUPER + SHIFT + LEFT",  hl.dsp.window.swap({ direction = "left"  }))
hl.bind("SUPER + SHIFT + RIGHT", hl.dsp.window.swap({ direction = "right" }))
hl.bind("SUPER + SHIFT + UP",    hl.dsp.window.swap({ direction = "up"    }))
hl.bind("SUPER + SHIFT + DOWN",  hl.dsp.window.swap({ direction = "down"  }))

for i = 1, 10 do
    local key = i % 10
    hl.bind("SUPER + " .. key,         hl.dsp.focus({ workspace = i}))
    hl.bind("SUPER + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

hl.bind("SUPER + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind("SUPER + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

hl.bind("SUPER + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind("XF86AudioRaiseVolume",  hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume",  hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",         hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",      hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })

hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })

hl.window_rule({
    name = "suppress-maximize-events",
    match = {
        class = ".*",
    },

    suppress_event = "maximize"
})

hl.window_rule({
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },

    no_focus = true
})

hl.window_rule({
    name  = "round-floating",
    match = {
        float = true,
    },

    rounding = 7,
    rounding_power = 8
})

hl.window_rule({
    name  = "move-code-oss-to-workspace-ii",
    match = {
        class = "code-oss"
    },

    workspace = 2
})

