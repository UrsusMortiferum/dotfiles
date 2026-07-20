{...}: {
  programs.git = {
    enable = true;
    config = {
      user.name = "UrsusMortiferum";
      user.email = "101043729+UrsusMortiferum@users.noreply.github.com";
      init.defaultBranch = "main";
    };
  };
}
