{
  den,
  ...
}:
{
  den.aspects.base = {
    includes = [
      den.batteries.hostname
    ];

    nixos = {
      networking = {
        networkmanager.enable = true;
      };

      # systemd.network.wait-online.enable = false;
      # boot.initrd.systemd.network.wait-online.enable = false;
      # services.resolved.enable = true;
    };

    user = {
      extraGroups = [
        "networkmanager"
      ];
    };
  };
}
