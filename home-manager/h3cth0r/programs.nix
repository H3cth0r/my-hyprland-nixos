{ pkgs, ... }:

{
  # Waybar configuration
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        modules-left = [ "hyprland/workspaces" "hyprland/mode" ];
        modules-center = [ "hyprland/window" ];
        modules-right = [ "pulseaudio" "network" "cpu" "memory" "clock" ];
        
        "hyprland/workspaces" = {
          format = "{icon}";
          format-icons = {
            "1" = "";
            "2" = "";
            "3" = "";
            "urgent" = "";
            "focused" = "";
            "default" = "";
          };
        };
        clock = {
          format = "{:%H:%M }";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        };
        # Add other module configs here...
      };
    };
  };

  # Rofi configuration
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    theme = "gruvbox-dark";
  };
  
  # SwayNC Notification Center
  services.swaync = {
    enable = true;
  };
}
