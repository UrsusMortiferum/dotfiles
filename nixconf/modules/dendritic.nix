{ inputs, lib, ... }:
{
  flake-file.inputs = {
    den.url = lib.mkDefault "github:denful/den";
    flake-file.url = lib.mkDefault "github:vic/flake-file";
    hjem = {
      url = lib.mkDefault "github:feel-co/hjem";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  imports = [
    (inputs.flake-file.flakeModules.dendritic or { })
    (inputs.den.flakeModules.dendritic or { })
  ];

  den.schema.user.classes = [ "hjem" ];
}
