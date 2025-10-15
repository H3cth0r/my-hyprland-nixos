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
        modules-left = [ "backlight" "pulseaudio" ];
        modules-center = [ "hyprland/window" "hyprland/workspaces" ];
        modules-right = [ "network" "cpu" "memory" "clock" ];
        
	"pulseaudio" = {
		format = "{icon}";
		format-muted = " Muted";
		format-icons = {
			headphone = "";
			hands-free = "󰥰";
			headset = "";
			phone = "󰥰";
			portable = "󰥰";
			car = "";
			default = [ "" " " " "];
		};
	};
	"network" = {
		format-wifi="󰖩 {essid}";
		format-ethernet="󰈁 {ifname}";
		format-disconnected="󱚵";
	};
	"cpu" = {
		format = " {usage}%";
		tooltip = " {usage}%";
	};
	"memory" = {
		format = " {used:0.1f}G/{total:0.1f}G";
	};
	"backlight" = {
		format = "{icon} {percent}%";
		format-icons = ["󰃜" "󰃛" "󰃚"];
		on-scroll-up = "brightnessctl set 5%+";
		on-scroll-down = "brightnessctl set 5%-";
	};
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
	"hyprland/window" = {
	  format="{}";
	  rewrite = {
	  	"(.*) Mozilla Firefox" = "󰈹 Firefox";
	  	"h3cth0r@nixos: (.*)" = " WezTerm";
	  };
	};
        clock = {
          format = "{:%H:%M 󰥔}";
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
