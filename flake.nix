{

  description = "playing around with nixos";

  inputs = {
    # nixpkgs.url = "github.NixOS/nixpkgs/nixos-unstable";
    nixpkgs.url = "nixpkgs/nixos-unstable";
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, ... }:
    let
      lib = inputs.nixpkgs.lib;
    in {
    nixosConfigurations = {
      cave = lib.nixosSystem {
        system = "x86_64-linux";
	modules = [ ./configuration.nix ];
	specialArgs = { inherit inputs; };
      };
    };
  };

}
