{ ... }:

{
  programs.wezterm = {
    enable = true;
    extraConfig = ''
      local wezterm = require 'wezterm'
      local config = {}
      
      config.color_scheme = 'Gruvbox dark, soft (base16)'
      config.font = wezterm.font 'JetBrains Mono'
      config.font_size = 12.0
      
      return config
    '';
  };
}
