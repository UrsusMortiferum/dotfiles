{ config, lib, pkgs, ... }:

let
  cfg = config.programs.amethyst-mod-manager;

  version = "2.1.0";
  pname = "amethyst-mod-manager";

  src = pkgs.fetchurl {
    url = "https://github.com/ChrisDKN/Amethyst-Mod-Manager/releases/download/v${version}/AmethystModManager-${version}-x86_64.AppImage";
    hash = "sha256-Nwt/2qS7CVkyZjHiNsKwcdb21QAN2Jtg9E9YGI9RCEk=";
  };

  amethyst-mod-manager = pkgs.buildFHSEnv {
    inherit pname version;
    runScript = "${src}";
    targetPkgs = pkgs: with pkgs; [ fuse fuse3 ];
  };
in
{
  options.programs.amethyst-mod-manager = {
    enable = lib.mkEnableOption "Amethyst Mod Manager";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ amethyst-mod-manager ];
  };
}
