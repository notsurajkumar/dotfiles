-- importing colors from wallust
local colors = dofile(os.getenv("HOME") .. "/.config/wallust/output/colors.lua")

-- window borders and gaps
hl.workspace_rule(
  {
    workspace = "r[1-100]",
    gaps_in = 3,
    gaps_out = 3,
    border_size = 1,
  }
)

-- general blur and special workspace blur settigns, and also corner radius
hl.config({
  decoration = {
    rounding = 0,
    rounding_power = 4,
    dim_special = 0.2,
    blur = {
      special = 1,
      size = 10,
      passes = 3,
    },
  },
  general = {
    snap = {
      enabled = true,
    },
  }
})

-- rofi blur
local myLayerRule = hl.layer_rule({
  name  = "my-layer-rule",
  match = { namespace = "rofi" },
  blur  = true,
})
myLayerRule:set_enabled(true)


-- custom animation curves I
hl.curve( "rubber", { type = "spring", mass = 1, stiffness = 90, dampening = 10 } )
hl.curve( "band", { type = "bezier", points = {{0.86, 0.08}, {0.28, 0.83} }} )
hl.curve( "hola", { type = "bezier", points = {{0.015, 0.610}, {0.355, 1} }} )

-- layout and basic decor for scratchpad
hl.workspace_rule({workspace = "special:scratchpad", gaps_in = 0, gaps_out = 10, layout = "scrolling" })
-- slide in from bottom for special workspace
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 6, bezier = "hola", style = "slidefadevert" })



-- custom animation curves II
hl.animation({ leaf = "workspaces", enabled = true, speed = 2.8, bezier = "hola", style = "slide" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 2, bezier = "hola", style = "slide" })


-- rofi opening and closing animation
hl.layer_rule({
  match = {
    namespace = "rofi"
  },
  no_anim = true,
  animation = "slide",
})


-- Force Kitty to suppress maximize requests from client side
hl.window_rule({
  match = {
    class = "^(kitty)$",
  }
})

-- Keep your unfocused opacity rule clean
hl.window_rule({
  match = {
    class = "^(kitty)$",
    focus = false,
  },
  opacity = 0.75,
})


--- waybar blur (to apply, reduce opacity of background of waybar from style.css)
hl.layer_rule({ match = { namespace = "waybar" }, blur = true })


--------------------------------------------------------------------------------
------------------- TEMPORARY FIDDLING AND TRYING THINGS OUT -------------------
--------------------------------------------------------------------------------

-- floating kitty tmp
hl.window_rule({
  name = "apply-something",
  match = {
    class= "custom-floating"
  },
  size = {200,90},
  float = true
})

hl.window_rule({
  name = "other",
  match = {
    class= "sample"
  },
  size = {200,90},
  float = true
})

