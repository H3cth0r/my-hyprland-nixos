{ pkgs, ... }:

{
  imports = [
    ./hyprland.nix
    ./neovim.nix
    ./tmux.nix
    ./programs.nix
    ./terminal.nix
  ];

  home.username = "h3cth0r";
  home.homeDirectory = "/home/h3cth0r";

  # Updated state version for a fresh 25.05 install
  home.stateVersion = "25.05";

  home.packages = with pkgs; [
    # Applications
    firefox
    
    # Utilities
    ripgrep
    fzf
    gnumake
    gcc
    xclip
    unzip
    
    # Styling and themeing
    swww
    rofi-wayland
    waybar
    fastfetch
    
    # Process viewer
    btop
  ];

  programs.bash.enable = true;
}
