{ pkgs, ... }:

let
   waybarCss = ./waybar/style.css;
in
{
  # Waybar configuration
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 20;
        modules-left = [ "hyprland/mode" ];
        modules-center = [ "hyprland/window" "hyprland/workspaces" ];
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

  xdg.configFile."waybar/style.css".source = waybarCss;

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
