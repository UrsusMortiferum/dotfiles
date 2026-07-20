{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    hardware.url = "github:NixOS/nixos-hardware/master";
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hjem = {
      url = "github:feel-co/hjem";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:nix-community/stylix/pull/2337/head";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/Hyprland";
    helium = {
      url = "github:AlvaroParker/helium-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dms = {
      url = "github:AvengeMedia/DankMaterialShell/stable";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    ...
  }: let
    homePath = ../home;
    inherit (self) outputs;
    systemSettings = {
      system = "x86_64-linux";
    };
    lib = nixpkgs.lib;
    sharedModules = [
      inputs.nix-index-database.nixosModules.default
      inputs.hjem.nixosModules.default
      inputs.stylix.nixosModules.stylix
      ./configuration.nix
      ./modules/default.nix
    ];
  in {
    overlays = import ./overlays {inherit inputs;};
    nixosConfigurations = {
      cave = lib.nixosSystem {
        inherit (systemSettings) system;
        modules = sharedModules;
        specialArgs = {
          inherit inputs outputs homePath;
          hostName = "cave";
        };
      };
      gpd = lib.nixosSystem {
        inherit (systemSettings) system;
        modules =
          sharedModules
          ++ [
            inputs.hardware.nixosModules.gpd-win-max-2-2023
          ];
        specialArgs = {
          inherit inputs outputs homePath;
          hostName = "gpd";
        };
      };
    };
  };
}
