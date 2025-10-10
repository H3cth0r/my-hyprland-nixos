{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./hyprland.nix
  ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Networking
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # Time zone
  time.timeZone = "America/Mexico_City";

  # Internationalisation
  i18n.defaultLocale = "en_US.UTF-8";

  # Sound with Pipewire
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # User account
  users.users.h3cth0r = {
    isNormalUser = true;
    description = "h3cth0r";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # System-wide packages
  environment.systemPackages = with pkgs; [
    wget
    git
    home-manager
  ];

  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Updated state version for a fresh 25.05 install
  system.stateVersion = "25.05";
}
