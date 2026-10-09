-- Other config files location
require("modules/keybinds")
require("modules/decorations")
require("modules/gestures")
require("modules/autostart")
require("modules/experiments")


-- hyprshot directory
hl.env("HYPRSHOT_DIR", os.getenv("HOME") .. "/Pictures/screenshots")


-- Disable forced scaling (for vlc)
hl.config({ xwayland = { force_zero_scaling = true } })


-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = "auto",
})


-- My programs
local terminal    = "kitty"
local fileManager = "dolphin"


-- Environment Variables
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
