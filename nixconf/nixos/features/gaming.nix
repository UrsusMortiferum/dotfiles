{
  self,
  ...
}:
{
  flake.nixosModules.gaming =
    {
      pkgs,
      lib,
      ...
    }:
    {
      imports = [ self.nixosModules.graphics ];
      programs = {
        gamescope = {
          enable = true;
          capSysNice = false;
        };
        steam = {
          enable = true;
          gamescopeSession.enable = true;
          protontricks.enable = true;
          extraCompatPackages = with pkgs; [
            proton-ge-bin
          ];
        };
      };

      environment.systemPackages = with pkgs; [
        gamescope-wsi
        heroic
        prismlauncher
        samrewritten
      ];
    };
}
