{
  inputs = {
    nixpkgs.url = "https://channels.nixos.org/nixos-unstable/nixexprs.tar.xz";
    # nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nix-gaming = {
      url = "github:fufexan/nix-gaming";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hjem = {
      url = "github:feel-co/hjem";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    helium = {
      url = "github:AlvaroParker/helium-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    emacs-overlay = {
      url = "github:nix-community/emacs-overlay";
    };
    stylix = {
      url = "github:nix-community/stylix/pull/2337/head";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/Hyprland";
    noctalia = {
      url = "github:noctalia-dev/noctalia/cachix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    noctalia-greeter = {
      url = "github:noctalia-dev/noctalia-greeter";
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
      inputs.noctalia.nixosModules.default
      inputs.noctalia-greeter.nixosModules.default
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
            inputs.nixos-hardware.nixosModules.gpd-win-max-2-2023
          ];
        specialArgs = {
          inherit inputs outputs homePath;
          hostName = "gpd";
        };
      };
    };
  };
}
