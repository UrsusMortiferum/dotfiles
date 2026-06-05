{
  den,
  lib,
  gotham,
  ...
}:
{
  den.aspects.ursus = {
    includes = [
      den.batteries.primary-user
      gotham.everything
    ];

    hjem =
      { pkgs, ... }:
      {
        packages = [ pkgs.htop ];
      };
  };
}
