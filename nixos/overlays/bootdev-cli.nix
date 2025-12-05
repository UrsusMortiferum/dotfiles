final: prev:

# let
#   version = "1.21.1";
# in

{
  bootdev-cli = prev.bootdev-cli.overrideAttrs (oldAttrs: {
    version = "1.21.1";
    src = prev.fetchFromGitHub {
      owner = "bootdotdev";
      repo = "bootdev";
      tag = "v${oldAttrs.version}";
      hash = "sha256-1uPI//w8RVqwRO1sVkI3vtdXduyuFp8632CVyAjkaSA=";
    };
  });
}
