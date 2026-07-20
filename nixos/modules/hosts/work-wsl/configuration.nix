{
  config,
  lub,
  pkgs,
  ...
}:
{
  imports = [
    <nixos-wsl/modules>
  ];
  wsl.enable = true;
  wsl.defaultUser = "ursus";

  # nix.settings.experimental-features = ["nix-command" "flakes"];

  # environment.systemPackages = with pkgs; [
  # neovim
  # git
  # coreutils
  # btop
  # curl
  # ];

  networking.proxy.default = "http://zscaler.proxy.int.kn:80";
  networking.proxy.noProxy = "127.0.0.1,localhost,*.int.kn";
  # networking.hostName = "work-wsl";
  networking.resolvconf.enable = false;

  services.openssh = {
    enable = true;
  };

  nix.settings.trusted-users = [
    "root"
    "@wheel"
    "ursus"
  ];

  users.users.ursus = {
    isNormalUser = true;
    group = "users";
    extraGroups = [
      "wheel"
      "docker"
    ];
    # shell = pkgs.zsh;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?
}
