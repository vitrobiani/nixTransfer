{
  description = "flake out";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-23.11";
    home-manager = {
            url = "github:nix-community/home-manager/release-23.11";
            inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
            url = "github:hyprwm/hyprland";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }:
let
    system = "x86_64-linux";
    lib = nixpkgs.lib;
    pkgs = nixpkgs.legacyPackages.${system};
in
{
    nixosConfigurations = {
            nixos = nixpkgs.lib.nixosSystem {
                inherit system;
                modules = [ ./configuration.nix ];
            };
        };
    homeConfigurations = {
            vitrobiani = home-manager.lib.homeManagerConfiguration{
                inherit pkgs;
                modules = [ ./home.nix ];
                };
        };

 };
}
