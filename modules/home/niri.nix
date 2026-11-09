{
  wayland.windowManager.niri = {
    enable = true;
    enableDefaultConfig = true;
    extraConfig = builtins.readFile ../../config/niri/config.kdl;    
  };
}
