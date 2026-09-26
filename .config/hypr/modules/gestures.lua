-- swipe bwetween workspaces 
hl.gesture({fingers = 3, direction = "horizontal", action = "workspace", scale = 0.1001})

-- swipe between workspaces configuration
hl.config({
    gestures = {
        workspace_swipe_distance = 25,
        workspace_swipe_cancel_ratio = 0.1,
        workspace_swipe_min_speed_to_force = 10,
    }
})


-- toggle fullscreen
hl.gesture({fingers = 3, direction = "down", action = "fullscreen", scale = 1.5 })


-- special workspace (open and close)
hl.gesture({ 
    fingers = 3, 
    direction = "up", 
    mods = "SUPER",
    action = "special", 
    workspace_name = "scratchpad" 
})

hl.gesture({ 
    fingers = 3, 
    direction = "down", 
    mods = "SUPER",
    action = "special", 
    workspace_name = "scratchpad" 
})



-- swipe in scrolling mode (same workspace)
hl.gesture({fingers = 4, direction = "horizontal", action = "scroll_move"})


-- touchpad scrolling settings
hl.config({
  input = {
    touchpad = {
      natural_scroll = true,
      scroll_factor = 0.18,
    }
  }
})
