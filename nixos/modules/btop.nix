{ homePath, pkgs, ... }: {
  environment.systemPackages = [ pkgs.btop-rocm ];
  # hjem.users.ursus.files = {
  #   ".config/btop/btop.conf".source = "${homePath}/btop/btop.conf";
  # };
}
