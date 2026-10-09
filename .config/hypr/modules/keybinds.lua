-- variables and default apps
local win = "SUPER"
local terminal = "kitty"
local fileManager = "dolphin"
local browser = "brave --profile-directory=Default"


-- Caps lock redirect and mod
hl.device({
        name = "at-translated-set-2-keyboard",
        kb_options = "caps:escape",
        kb_options = "caps:escape_shifted_capslock",
})


-- resize windows
hl.bind("SUPER + R", hl.dsp.submap("resize"))
hl.define_submap("resize", function()

    -- Set repeating binds for resizing the active window.
    hl.bind("L", hl.dsp.window.resize({ x = 10, y = 0, relative = true}), { repeating = true })
    hl.bind("H", hl.dsp.window.resize({ x = -10, y = 0, relative = true}), { repeating = true })
    hl.bind("J", hl.dsp.window.resize({ x = 0, y = 10, relative = true}), { repeating = true })
    hl.bind("K", hl.dsp.window.resize({ x = 0, y = -10, relative = true}), { repeating = true })

    -- Use `reset` to go back to the global submap
    hl.bind("Caps_Lock", hl.dsp.submap("reset"))
    hl.bind("escape", hl.dsp.submap("reset"))

end)
-- Keybinds further down will be global again...


-- display brightness using fn keys
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })


-- toggle waybar without killing it
hl.bind("SUPER + B", hl.dsp.exec_cmd("killall -SIGUSR1 waybar"))

-- toggle fullscreen
hl.bind("SUPER + A", hl.dsp.window.fullscreen())

-- floating view
hl.bind("SUPER + F", hl.dsp.window.float({ action = "toggle" }))

-- wallpaper switcher
hl.bind("SUPER + W", hl.dsp.exec_cmd("bash /home/rudra/scripts/wallpaper_switcher/wallpaper_switcher.sh"))
hl.bind("CTRL + SUPER + W", hl.dsp.exec_cmd("bash /home/rudra/scripts/wallpaper_switcher/new.sh"))

-- rofi launcher
hl.bind("CTRL + space", hl.dsp.exec_cmd("rofi -show drun"))

-- task manager
hl.bind("CTRL + SHIFT + escape ", hl.dsp.exec_cmd("kitty btop"))

-- clipboard manager rofi
hl.bind("SUPER + V", hl.dsp.exec_cmd("bash ~/scripts/clipboard/text"))
hl.bind("SUPER + CTRL + V", hl.dsp.exec_cmd("bash ~/scripts/clipboard/img"))

-- launch and kill apps
hl.bind("SUPER + Return", hl.dsp.exec_cmd(terminal))
hl.bind("SUPER + E", hl.dsp.exec_cmd(fileManager))
hl.bind("SUPER + Z", hl.dsp.exec_cmd(browser))
hl.bind("CTRL + SUPER + Z", hl.dsp.exec_cmd("brave --profile-directory=\"Profile 1\""))
hl.bind("CTRL + SUPER + Q", hl.dsp.window.close())


-- ==============================================================================
-- Window & Focus Management
-- ==============================================================================
-- move focus  
hl.bind("SUPER + H", hl.dsp.focus({ direction = "l" }))
hl.bind("SUPER + L", hl.dsp.focus({ direction = "r" }))
hl.bind("SUPER + K", hl.dsp.focus({ direction = "u" }))
hl.bind("SUPER + J", hl.dsp.focus({ direction = "d" }))

-- Move active window around current workspace
hl.bind("SUPER + SHIFT + H", hl.dsp.window.move({ direction = "l" }))
hl.bind("SUPER + SHIFT + L", hl.dsp.window.move({ direction = "r" }))
hl.bind("SUPER + SHIFT + K", hl.dsp.window.move({ direction = "u" }))
hl.bind("SUPER + SHIFT + J", hl.dsp.window.move({ direction = "d" }))

-- control windows with mouse
hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })


-- ==============================================================================
-- Workspace Management
-- ==============================================================================
-- move between workspaces
hl.bind("SUPER + 1", hl.dsp.focus({ workspace = "1" }))
hl.bind("SUPER + 2", hl.dsp.focus({ workspace = "2" }))
hl.bind("SUPER + 3", hl.dsp.focus({ workspace = "3" }))
hl.bind("SUPER + 4", hl.dsp.focus({ workspace = "4" }))
hl.bind("SUPER + 5", hl.dsp.focus({ workspace = "5" }))
hl.bind("SUPER + 6", hl.dsp.focus({ workspace = "6" }))
hl.bind("SUPER + 7", hl.dsp.focus({ workspace = "7" }))
hl.bind("SUPER + 8", hl.dsp.focus({ workspace = "8" }))




hl.bind("SUPER + CTRL + H", hl.dsp.focus({ workspace = "e-1" }))
hl.bind("SUPER + CTRL + J", hl.dsp.focus({ workspace = "e-1" }))
hl.bind("SUPER + CTRL + L", hl.dsp.focus({ workspace = "e+1" }))
hl.bind("SUPER + CTRL + K", hl.dsp.focus({ workspace = "e+1" }))

-- move windows between workspaces
hl.bind("SUPER + SHIFT + 0", hl.dsp.window.move({ workspace = "special:scratchpad" }))
hl.bind("SUPER + SHIFT + 2", hl.dsp.window.move({ workspace = "2" }))
hl.bind("SUPER + SHIFT + 1", hl.dsp.window.move({ workspace = "1" }))
hl.bind("SUPER + SHIFT + 2", hl.dsp.window.move({ workspace = "2" }))
hl.bind("SUPER + SHIFT + 3", hl.dsp.window.move({ workspace = "3" }))
hl.bind("SUPER + SHIFT + 4", hl.dsp.window.move({ workspace = "4" }))
hl.bind("SUPER + SHIFT + 5", hl.dsp.window.move({ workspace = "5" }))
hl.bind("SUPER + SHIFT + 6", hl.dsp.window.move({ workspace = "6" }))
hl.bind("SUPER + SHIFT + 7", hl.dsp.window.move({ workspace = "7" }))
hl.bind("SUPER + SHIFT + 8", hl.dsp.window.move({ workspace = "8" }))


-- ==============================================================================
-- Media & Hardware Controls
-- ==============================================================================
-- brightness control
hl.bind("SHIFT + mouse_up", hl.dsp.exec_cmd("brightnessctl set 1%-"))
hl.bind("SHIFT + mouse_down", hl.dsp.exec_cmd("brightnessctl set 1%+"))

-- screenshot
hl.bind("SUPER + S", hl.dsp.exec_cmd("hyprshot --clipboard-only -m region"))
hl.bind("SUPER + CTRL + S", hl.dsp.exec_cmd("hyprshot -m region"))
hl.bind("SUPER + SHIFT + S", hl.dsp.exec_cmd("hyprshot -m output -m active"))

-- Volume via Script
hl.bind("SUPER + mouse_up", hl.dsp.exec_cmd("~/.config/hypr/volume.sh down"))
hl.bind("SUPER + mouse_down", hl.dsp.exec_cmd("~/.config/hypr/volume.sh up"))
hl.bind("SUPER + Up", hl.dsp.exec_cmd("~/.config/hypr/volume.sh up"))
hl.bind("SUPER + Down", hl.dsp.exec_cmd("~/.config/hypr/volume.sh down"))

-- Mute Toggle
hl.bind("ALT + CTRL + M", hl.dsp.exec_cmd("~/.config/hypr/volume.sh zero && wpctl get-volume @DEFAULT_AUDIO_SINK@"))

hl.bind("SHIFT + CTRL + D", hl.dsp.dpms({ action = "enable" }))

-- copilot key reassign
hl.bind("ALT + SUPER + SHIFT + F23", hl.dsp.exec_cmd("hyprlock"))
hl.bind("SUPER + SHIFT + F23", hl.dsp.exec_cmd("dex ~/.local/share/applications/webapps/gemini.desktop"))
hl.bind("CTRL + SUPER + SHIFT + F23", hl.dsp.exec_cmd("dex ~/.local/share/applications/webapps/chatgpt.desktop"))


-- toggle dwindle and scrolling
hl.bind("SUPER + tab", function ()
    local layouts     = { "scrolling", "dwindle" }
    local workspace   = hl.get_active_workspace()
	if hl.get_active_special_workspace() then
		workspace = hl.get_active_special_workspace()
	end

    local next_layout = "dwindle"

    if not workspace then
        return
    end

    for i = 1, #layouts do
        if layouts[i] == workspace.tiled_layout then
            local next_layout_idx = (i % #layouts) + 1
            next_layout = layouts[next_layout_idx]
            break
        end
    end

	if workspace.special then
		hl.workspace_rule({ workspace = tostring(workspace.name), layout = next_layout })
	else
		hl.workspace_rule({ workspace = tostring(workspace.id), layout = next_layout })
	end
end)


--------------------------------------------------------------------------------
------------------- TEMPORARY FIDDLING AND TRYING THINGS OUT -------------------
--------------------------------------------------------------------------------

hl.window_rule({
    name = "help-menu-float",
    match = { class = "^(floating-help)$" },
    float = true,
    size = "300 500",
    center = true
})


hl.bind("SUPER + C", hl.dsp.layout("expel"))
hl.bind("SUPER + X", hl.dsp.layout("togglesplit"))


hl.config({
  dwindle = {
      preserve_split = true,
  },
})
