# { ... }:
#
# {
#   additions = final: _prev: import ../pkgs final.pkgs;
#   modifications = final: prev: {
#     inherit (import ./bootdev-cli.nix final prev) bootdev-cli;
#     inherit (import ./rimsort.nix final prev) rimsort;
#     inherit (import ./proton-vpn.nix final prev) proton-vpn;
#   };
# }

{ ... }:

{
  additions = final: prev: import ../pkgs final.pkgs;

  modifications = final: prev: (import ./rimsort.nix final prev);
  # (import ./bootdev-cli.nix final prev)
  # // (import ./rimsort.nix final prev)
  # // (import ./proton-vpn.nix final prev);
}
