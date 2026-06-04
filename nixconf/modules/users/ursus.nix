{
  den,
  lib,
  shared,
  ...
}:
{
  den.aspects.ursus = {
    includes = [
      den.batteries.primary-user
      shared.everything
    ];

    hjem =
      { pkgs, ... }:
      {
        packages = [ pkgs.htop ];
      };
  };
}
