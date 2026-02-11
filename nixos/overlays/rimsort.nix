final: prev:

{
  rimsort = prev.rimsort.overrideAttrs (oldAttrs: {
    version = "1.0.68";
    src = prev.fetchFromGitHub {
      owner = "RimSort";
      repo = "RimSort";
      # rev = "v${oldAttrs.version}";
      tag = "v${oldAttrs.version}";
      hash = "sha256-HNeB0W9kqEGQCKKX5Sk8F8ge77kxf0CI8fAlywutsRo=";
    };
  });
}
