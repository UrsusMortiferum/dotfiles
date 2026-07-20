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
      "https://nix-community.cachix.org"
      "https://hyprland.cachix.org"
    ];
    trusted-substituters = [];
    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
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
