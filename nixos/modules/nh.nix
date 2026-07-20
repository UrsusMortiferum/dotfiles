{...}: {
  programs.nh = {
    enable = true;
    flake = "/home/ursus/workspace/github.com/UrsusMortiferum/dotfiles/nixos";
    clean.enable = true;
    clean.dates = "weekly";
    clean.extraArgs = "--keep-since 15d --keep 15";
  };
}
