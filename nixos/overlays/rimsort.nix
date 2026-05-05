final: prev:

{
  rimsort = prev.rimsort.overrideAttrs (oldAttrs: {
    version = "1.0.68";
    src = prev.fetchFromGitHub {
      owner = "RimSort";
      repo = "RimSort";
      # rev = "v${oldAttrs.version}";
      tag = "v${oldAttrs.version}";
      hash = "sha256-eVKl2xh+Qzg5BrgY7Da8+6ImahmSvP2fTWJsEnIJ2AI=";
    };
  });
}
