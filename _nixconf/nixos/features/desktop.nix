{ inputs, ... }:
{
  flake.nixosModules.desktop =
    { pkgs, ... }:
    {
      imports = [
        inputs.silentSDDM.nixosModules.default
      ];

      programs.silentSDDM = {
        enable = true;
        theme = "rei";
      };

      programs.hyprland = {
        enable = true;
        package = inputs.hyprland.packages.${pkgs.system}.hyprland;
        portalPackage = inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland;
        withUWSM = true;
        xwayland = {
          enable = true;
        };
      };

      # TODO: Get rid of waybar
      programs.waybar = {
        enable = true;
      };
    };
}
