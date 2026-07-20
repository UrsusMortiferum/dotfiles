{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    hardware.url = "github:NixOS/nixos-hardware/master";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:nix-community/stylix/pull/2337/head";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/Hyprland";
    # zen-browser = {
    #   url = "github:0xc000022070/zen-browser-flake";
    #   inputs.home-manager.follows = "home-manager";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    helium = {
      url = "github:AlvaroParker/helium-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dms = {
      url = "github:AvengeMedia/DankMaterialShell/stable";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  # outputs = inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } (inputs.import-tree ./modules);
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
        work-wsl = lib.nixosSystem {
          inherit (systemSettings) system;
          modules = [
            ./configuration.nix
            home-manager
            stylix
          ];
          specialArgs = {
            inherit inputs outputs;
            hostName = "work-wsl";
          };
        };
      };
    };
}
