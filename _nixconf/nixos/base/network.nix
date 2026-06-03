{ ... }:
{
  flake.nixosModules.network =
    { ... }:
    {
      networking = {
        networkmanager.enable = true;
      };

      services.openssh.enable = true;
      services.fail2ban.enable = true;
      programs.ssh.startAgent = true;
    };
}
