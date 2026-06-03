{ ... }:
{
  flake.nixosModules.graphics =
    {
      pkgs,
      lib,
      ...
    }:
    {
      hardware.enableRedistributableFirmware = true;
      hardware.graphics = {
        enable = lib.mkDefault true;
        enable32Bit = true;
        extraPackages = with pkgs; [
          mesa
        ];
        extraPackages32 = with pkgs; [
          driversi686Linux.mesa
        ];
      };
    };
}
