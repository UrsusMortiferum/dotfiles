{ homePath, pkgs, ... }: {
  environment.systemPackages = [ pkgs.btop ];
  hjem.users.ursus.files = {
    ".config/btop/btop.conf".source = "${homePath}/btop/btop.conf";
  };
}
