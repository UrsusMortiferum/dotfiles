{

  description = "playing around with nixos";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
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
      };
    };

}
