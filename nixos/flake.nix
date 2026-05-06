{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    hardware.url = "github:NixOS/nixos-hardware/master";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.home-manager.follows = "home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      ...
    }:
    let
      inherit (self) outputs;
      systemSettings = {
        system = "x86_64-linux";
        timezone = "Europe/Amsterdam";
      };
      lib = nixpkgs.lib;
      home-manager = inputs.home-manager.nixosModules.home-manager;
      stylix = inputs.stylix.nixosModules.stylix;
    in
    {
      overlays = import ./overlays { inherit inputs; };
      nixosConfigurations = {
        cave = lib.nixosSystem {
          inherit (systemSettings) system;
          modules = [
            ./configuration.nix
            home-manager
            stylix
          ];
          specialArgs = {
            inherit inputs outputs;
            hostName = "cave";
          };
        };
        gpd = lib.nixosSystem {
          inherit (systemSettings) system;
          modules = [
            ./configuration.nix
            home-manager
            stylix
            inputs.hardware.nixosModules.gpd-win-max-2-2023
          ];
          specialArgs = {
            inherit inputs outputs;
            hostName = "gpd";
          };
        };
      };
    };
}
