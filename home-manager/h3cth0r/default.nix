{ pkgs, superfile, ... }:

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

    superfile.packages.${pkgs.system}.default

    # Applications
    firefox
    
    # Utilities
    ripgrep
    fzf
    gnumake
    gcc
    xclip
    unzip
    wl-clipboard
    
    # Styling and themeing
    swww
    waybar
    fastfetch

    # cursors
    bibata-cursors

    # fonts
    nerd-fonts.jetbrains-mono
    
    # Process viewer
    btop

    # brightness control
    brightnessctl
  ];

  programs.bash.enable = true;
}
