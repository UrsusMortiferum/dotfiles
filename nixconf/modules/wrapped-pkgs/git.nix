{ inputs, ... }:
{
  perSystem =
    { pkgs, ... }:
    {
      packages.git = inputs.wrappers.lib.wrapPackage {
        inherit pkgs;
        package = pkgs.git;
        env = rec {
          GIT_AUTHOR_NAME = "UrsusMortiferum";
          GIT_AUTHOR_EMAIL = "101043729+UrsusMortiferum@users.noreply.github.com";
          GIT_COMMITTER_NAME = GIT_AUTHOR_NAME;
          GIT_COMMITTER_EMAIL = GIT_AUTHOR_EMAIL;
        };
      };
    };
}
