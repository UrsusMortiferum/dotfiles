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
      inputs.home-manager.follows = "home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    vieb-nix = {
      url = "github:tejing1/vieb-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:nix-community/stylix";
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
      systemSettings = {
        system = "x86_64-linux";
        timezone = "Europe/Amsterdam";
      };
      lib = nixpkgs.lib;
      home-manager = inputs.home-manager.nixosModules.home-manager;
      stylix = inputs.stylix.nixosModules.stylix;
    in
    {
      nixosConfigurations = {
        cave = lib.nixosSystem {
          inherit (systemSettings) system;
          modules = [
            ./configuration.nix
            home-manager
            stylix
          ];
          specialArgs = { inherit inputs; };
        };
        gpd = lib.nixosSystem {
          modules = [
            ./configuration.nix
            home-manager
            stylix
            inputs.nixos-hardware.nixosModules.gpd-win-max-2-2023
          ];
          specialArgs = { inherit inputs; };
        };
      };
    };
}
