{ den, lib, ... }:
{
  den.aspects.batmobile = {
    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = [ pkgs.hello ];
      };
  };
}
