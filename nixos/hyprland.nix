{ pkgs, ... }:

{
  # Enable the Hyprland Wayland compositor
  programs.hyprland.enable = true;

  # Enable XWayland for running X11 applications
  programs.xwayland.enable = true;

  # Use greetd as a secure, lightweight display manager
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --cmd Hyprland";
        user = "greeter";
      };
    };
  };

  # Required for certain services and screen sharing
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
  };

  # Fonts for a good out-of-the-box experience
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    font-awesome # For icons in Waybar
  ];
}
