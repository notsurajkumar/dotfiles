hl.on("hyprland.start", function () 
  
  -- applications and daemons
  hl.exec_cmd("waybar & hypridle & awww-daemon") 

  -- clipboard daemon
  hl.exec_cmd("wl-paste --type text --watch cliphist store")
  hl.exec_cmd("wl-paste --type image --watch cliphist store")

  -- polkit (windows partition share) and dolphin for unlocking drives
  hl.exec_cmd("/usr/lib/polkit-kde-authentication-agent-1")

  -- brave browser preloader for faster first start
  -- hl.exec_cmd("brave-browser --no-startup-window")

end)



