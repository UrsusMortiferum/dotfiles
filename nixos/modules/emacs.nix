{ inputs, pkgs, ... }:
{
  nixpkgs.overlays = [ inputs.emacs-overlay.overlays.default ];

  services.emacs = {
    enable = true;
    package = pkgs.emacs.pkgs.withPackages (ep: [
      # ep.ghostel
    ]);
  };

}
