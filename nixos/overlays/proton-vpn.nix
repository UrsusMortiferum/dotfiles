# final: prev: {
#   # Work around Proton's unpinned Python dependency graph by rebuilding
#   # the GTK app against the api-core release that exports `Location`.
#   pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
#     (_: python-prev: {
#       proton-vpn-api-core = python-prev.proton-vpn-api-core.overridePythonAttrs (_: rec {
#         version = "4.19.1";
#         src = prev.fetchFromGitHub {
#           owner = "ProtonVPN";
#           repo = "python-proton-vpn-api-core";
#           rev = "v${version}";
#           hash = "sha256-PD/UQ+BoDO6firhlBJDRNrtiHgnp+4uIb8j+egXqxPA=";
#         };
#       });
#     })
#   ];
#   proton-vpn = final.callPackage (prev.path + "/pkgs/by-name/pr/proton-vpn/package.nix") { };
# }
final: prev:
let
  coreVersion = "4.19.1";
  coreSrc = prev.fetchFromGitHub {
    owner = "ProtonVPN";
    repo = "python-proton-vpn-api-core";
    rev = "v${coreVersion}";
    hash = "sha256-PD/UQ+BoDO6firhlBJDRNrtiHgnp+4uIb8j+egXqxPA=";
  };
in
{
  pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
    (pythonFinal: pythonPrev: {
      proton-vpn-api-core = pythonPrev.proton-vpn-api-core.overridePythonAttrs (old: {
        version = coreVersion;
        src = coreSrc;
      });
    })
  ];

  # keep if you really need to ensure proton-vpn is from nixpkgs scope
  proton-vpn = final.callPackage (prev.path + "/pkgs/by-name/pr/proton-vpn/package.nix") { };
}
