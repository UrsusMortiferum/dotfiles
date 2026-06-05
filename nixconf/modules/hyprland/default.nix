{
  inputs,
  shared,
  ...
}:
{
  flake-file.inputs.hyprland.url = "github:hyprwm/Hyprland";

  shared.everything.includes = [ shared.hyprland-desktop ];
  shared.hyprland-desktop = {
    nixos = {
      nixpkgs.overlays = [
        inputs.hyprland.overlays.hyprland-packages
        inputs.hyprland.overlays.hyprland-extras
      ];
      programs.hyprland = {
        enable = true;
        withUWSM = true;
        # xwayland.enable = true;
      };
    };
  };

  den.aspects.ursus.hjem = {
    directory = "/home/ursus";
    files = {
      # Move hypr config dir here later
      # Btw, it works :)
      ".config/hypr".source = ./hypr;
    };
  };
}
