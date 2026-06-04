{
  den,
  ...
}:
{
  den.default = {
    nixos = {
      i18n.defaultLocale = "en_US.UTF-8";
      time.timeZone = "Europe/Amsterdam";
      system.stateVersion = "25.05";
    };
    includes = [
      den.batteries.define-user
      den.batteries.hostname
    ];
    schema.host.hjem.enable = true;
  };

  # User TODO: REMOVE THIS
  den.aspects.ursus.nixos = {
    boot.loader.grub.enable = false;
    fileSystems."/".device = "/dev/fake";
    fileSystems."/".fsType = "auto";
  };
}
