{pkgs, ...}: {
  # Allow unfree packages globally
  nixpkgs.config.allowUnfree = true;

  # Nix daemon settings
  nix.settings = {
    auto-optimise-store = true;
    experimental-features = [
      "nix-command"
      "flakes"
      "pipe-operators"
    ];
    substituters = [
      "https://cache.nixos.org/"
      # "https://nix-community.cachix.org"
      "https://hyprland.cachix.org"
      "https://noctalia.cachix.org"
    ];
    trusted-substituters = [];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      # "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
    ];
  };

  # Optimisation schedule
  nix.optimise = {
    automatic = true;
    dates = ["00:00"];
  };

  # Enable programs from nix-index-database
  programs.nix-index.enable = true;
  programs.nix-index-database.comma.enable = true;
  programs.nix-ld.enable = true;

  # Direnv
  programs.direnv = {
    enable = true;
    silent = false;
    loadInNixShell = true;
    direnvrcExtra = "";
    nix-direnv.enable = true;
  };

  # Nix development tooling
  environment.systemPackages = with pkgs; [
    nil
    nixd
    statix
    alejandra
    manix
    nix-inspect
  ];
}
