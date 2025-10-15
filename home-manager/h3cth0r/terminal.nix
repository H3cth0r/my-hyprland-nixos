{ ... }:

{
  programs.wezterm = {
    enable = true;
    extraConfig = ''
      local wezterm = require 'wezterm'
      local config = {}

      config.font = wezterm.font 'JetBrainsMono Nerd Font'
      config.font_size = 12.0
      
      config.color_scheme = 'Gruvbox dark, soft (base16)'

      -- Opacity Settings for active and inactive states
      local active_opacity = 0.85

      config.enable_tab_bar = false

      -- set initial background opacity
      config.window_background_opacity = active_opacity

      config.window_frame = {
      	active_titlebar_bg = 'rgba(50,48,47,0.85)',
      	inactive_titlebar_bg = 'rgba(50,48,47,0.85)'
      }

	config.tab_bar_style = {
	}

      return config
    '';
  };
}
