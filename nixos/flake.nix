{
  description = "playing around with nixos";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    # nixpkgs.url = "nixpkgs/nixos-unstable-small";
    # Keeping those, in case I would like to have something more "stable" on different host
    nixpkgs-stable.url = "nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";

    hardware = {
      url = "github:NixOS/nixos-hardware/master";
    };
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Declarative partitioning and formatting
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Browser of choice
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.home-manager.follows = "home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Theming
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Testing random stuff
    # vieb-nix = {
    #   url = "github:tejing1/vieb-nix";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    hyprland.url = "github:hyprwm/Hyprland";
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
