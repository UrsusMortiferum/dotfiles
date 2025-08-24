{

  description = "playing around with nixos";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware = {
      url = "github:NixOS/nixos-hardware/master";
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    vieb-nix = {
      url = "github:tejing1/vieb-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{ self, ... }:
    let
      systemSettings = {
        system = "x86_64-linux";
        timezone = "Europe/Amsterdam";
      };
      lib = inputs.nixpkgs.lib;
    in
    {
      nixosConfigurations = {
        cave = lib.nixosSystem {
          inherit (systemSettings) system;
          modules = [
            ./configuration.nix
            inputs.home-manager.nixosModules.home-manager
          ];
          specialArgs = { inherit inputs; };
        };
        gpd = lib.nixosSystem {
          modules = [
            ./configuration.nix
            inputs.home-manager.nixosModules.home-manager
            inputs.nixos-hardware.nixosModules.gpd-win-max-2-2023
          ];
          specialArgs = { inherit inputs; };
        };
      };
    };

}
