{homePath, ...}: {
  imports = [./git.nix];

  users.users.ursus = {
    isNormalUser = true;
    description = "ursus";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };

  hjem.users.ursus = {
    directory = "/home/ursus";
    files = {
      ".config/nvim".source = "${homePath}/nvim";
  ".config/ghostty".source = "${homePath}/ghostty";
  ".config/hypr".source = "${homePath}/hypr";
    };
  };
}
