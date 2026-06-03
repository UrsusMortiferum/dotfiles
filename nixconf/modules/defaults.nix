{ lib, den, ... }:
{
  den.default.nixos.system.stateVersion = "25.05";
  den.default.homeManager.home.stateVersion = "25.05";

  # enable hm by default
  # den.schema.user.classes = lib.mkDefault [ "homeManager" ];
  # Enable hjem by default on all hosts
  den.schema.host.hjem.enable = true;

  # User TODO: REMOVE THIS
  den.aspects.tux.nixos = {
    boot.loader.grub.enable = false;
    fileSystems."/".device = "/dev/fake";
    fileSystems."/".fsType = "auto";
  };
}
