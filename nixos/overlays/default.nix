{ ... }:

{
  additions = final: _prev: import ../pkgs final.pkgs;
  modifications = final: prev: {
    inherit (import ./bootdev-cli.nix final prev) bootdev-cli;
  };
}
