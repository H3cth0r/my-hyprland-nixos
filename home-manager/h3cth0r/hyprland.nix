{ pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = ''
      # See https://wiki.hyprland.org/Configuring/Monitors/
      monitor = eDP-1, 1920x1080@60, 0x0, 1
      monitor = HDMI-A-1, preferred, 1920x0, 1

      # Clamshell script
      bindl = , switch:on:Lid Switch, exec, hyprctl --batch "keyword monitor eDP-1, disable; keyword monitor HDMI-A-1, preferred, 0x0, 1"
      bindl = , switch:off:Lid Switch, exec, hyprctl --batch "keyword monitor eDP-1, 1920x1080@60, 0x0, 1; keyword monitor HDMI-A-1, preferred, 1920x0, 1"

      # Programs to launch on startup
      exec-once = waybar & swaync & swww init

      # Source a script to set a random wallpaper
      exec-once = ~/.config/hypr/scripts/wallpaper.sh

      # Environment variables
      env = XCURSOR_SIZE,24

      # Input settings
      input {
          kb_layout = us
          kb_variant =
          kb_model =
          kb_options =
          kb_rules =

          follow_mouse = 1

          touchpad {
              natural_scroll = no
          }

          sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
      }

      # General settings
      general {
          gaps_in = 5
          gaps_out = 10
          border_size = 2
          col.active_border = rgba(FFFFFF4D)
          col.inactive_border = rgba(595959aa)
          layout = dwindle
      }

      decoration {
          rounding = 10
          blur {
            enabled = true
            size = 3
            passes = 1
          }
	  inactive_opacity = 0.8
	  shadow {
		enabled = yes
		range = 4
          	render_power = 3
		color = rgba(1a1a1aee)
	  }
      }

      animations {
          enabled = yes
          bezier = myBezier, 0.05, 0.9, 0.1, 1.05
          animation = windows, 1, 7, myBezier
          animation = windowsOut, 1, 7, default, popin 80%
          animation = border, 1, 10, default
          animation = fade, 1, 7, default
          animation = workspaces, 1, 6, default
      }

      dwindle {
          pseudotile = yes
          preserve_split = yes
      }


      # Keybindings
      $mainMod = SUPER # Sets the "Windows" key as the main modifier

      bind = $mainMod, Q, exec, ${pkgs.wezterm}/bin/wezterm
      bind = $mainMod, C, killactive,
      bind = $mainMod, M, exit,
      bind = $mainMod, E, exec, ${pkgs.wezterm}/bin/wezterm start btop # Keybind for btop
      bind = $mainMod, D, exec, rofi -show drun
      bind = $mainMod, P, pseudo, # dwindle
      bind = $mainMod, J, togglesplit, # dwindle

      # Move focus with mainMod + arrow keys
      bind = $mainMod, left, movefocus, l
      bind = $mainMod, right, movefocus, r
      bind = $mainMod, up, movefocus, u
      bind = $mainMod, down, movefocus, d

      # Switch workspaces with mainMod + [0-9]
      bind = $mainMod, 1, workspace, 1
      bind = $mainMod, 2, workspace, 2
      bind = $mainMod, 3, workspace, 3

      # Move active window to a workspace with mainMod + SHIFT + [0-9]
      bind = $mainMod SHIFT, 1, movetoworkspace, 1
      bind = $mainMod SHIFT, 2, movetoworkspace, 2
      bind = $mainMod SHIFT, 3, movetoworkspace, 3

      # Move currently focused workspace to the monitor on left or right
      bind = $mainMod ALT, left, movecurrentworkspacetomonitor, l
      bind = $mainMod ALT, right, movecurrentworkspacetomonitor, r
      
      # Change wallpaper with a keybind
      bind = $mainMod, B, exec, ~/.config/hypr/scripts/wallpaper.sh
      
      # Blur Waybar
      layerrule = blur, waybar
      layerrule = ignorezero, waybar

      # Blur Rofi
      layerrule = blur, rofi
      layerrule = ignorezero, rofi

    '';
  };

  # Create a script for managing wallpapers
  home.file.".config/hypr/scripts/wallpaper.sh" = {
    executable = true;
    text = ''
      #!/bin/sh
      # This script sets a random wallpaper from the ~/Pictures/wallpapers directory
      
      WALLPAPER_DIR="$HOME/Pictures/wallpapers"
      if [ ! -d "$WALLPAPER_DIR" ]; then
        mkdir -p "$WALLPAPER_DIR"
        echo "Please add wallpapers to $WALLPAPER_DIR" > "$WALLPAPER_DIR/readme.txt"
        exit 0
      fi

      WALLPAPER=$(find "$WALLPAPER_DIR" -type f | shuf -n 1)
      
      if [ -f "$WALLPAPER" ]; then
        swww img "$WALLPAPER" --transition-type any
      fi
    '';
  };

  gtk.cursorTheme = {
  	name = "Bibata-Modern-Classic";
	package = pkgs.bibata-cursors;
  };
  xresources.properties."Xcursor.theme" = "Bibata-Modern-Classic";
  home.sessionVariables = {
    XCURSOR_THEME = "Bibata-Modern-Classic";
  };
}
