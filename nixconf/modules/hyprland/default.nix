{
  inputs,
  gotham,
  ...
}:
{
  flake-file.inputs.hyprland.url = "github:hyprwm/Hyprland";

  gotham.everything.includes = [ gotham.hyprland-desktop ];
  gotham.hyprland-desktop = {
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
      # TODO: Figure out the way to establish same config across various users
      # Move hypr config dir here later
      # Btw, it works :)
      # ".config/hypr".source = ./hypr;
    };
  };
}
