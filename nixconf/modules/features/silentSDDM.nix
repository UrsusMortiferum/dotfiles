{ inputs, ... }:
{
  flake.nixosModules.silentSDDM =
    { pkgs, ... }:
    {
      imports = [
        inputs.silentSDDM.nixosModules.default
      ];

      programs.silentSDDM = {
        enable = true;
        theme = "rei";
      };
    };
}
