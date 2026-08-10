{...}: {
  programs.nh = {
    enable = true;
    flake = "/home/ursus/workspace/codeberg.org/yogurt861/dotfiles/nixos";
    clean.enable = true;
    clean.dates = "weekly";
    clean.extraArgs = "--keep-since 15d --keep 15";
  };
}
