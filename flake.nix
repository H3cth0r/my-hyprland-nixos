{
  description = "A flake for a Hyprland-based NixOS system";

  inputs = {
    # Updated for 25.05
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";

    # Updated for 25.05
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { };
      modules = [
        ./nixos/configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.h3cth0r = import ./home-manager/h3cth0r/default.nix;
        }
      ];
    };
  };
}
