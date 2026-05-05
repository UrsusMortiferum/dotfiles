final: prev:
let
  versionNew = "1.29.2";
  inherit (prev) lib stdenv;
in
{
  bootdev-cli = prev.bootdev-cli.overrideAttrs (oldAttrs: {
    version = versionNew;
    src = prev.fetchFromGitHub {
      owner = "bootdotdev";
      repo = "bootdev";
      tag = "v${versionNew}";
      hash = "sha256-POOxwveDSQ3hiybFKmI2eQQEbxN45ubmfEUkLk7i/ng=";
    };
    postInstall = lib.optionalString (stdenv.buildPlatform.canExecute stdenv.hostPlatform) ''
      for shell in bash fish zsh; do
        installShellCompletion --cmd bootdev --"$shell" <($out/bin/bootdev completion "$shell")
        done
    '';
  });
}
