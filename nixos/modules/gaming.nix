{ pkgs, ... }:
{
  programs = {
    steam = {
      enable = true;
      gamescopeSession.enable = true;
      protontricks.enable = true;
      # extraPackages = with pkgs; [
      #   gamescope
      # ];
      extraCompatPackages = with pkgs; [
        proton-ge-bin
        # steamtinkerlaunch
        # protonup-qt
        # freetype
        # fontconfig
        # protontricks
      ];
    };
    # gamescope = {
    #   enable = true;
    #   enableWsi = true;
    #   # capSysNice = true;
    #   args = [
    #     "-W 3840"
    #     "-H 2160"
    #     "-r 120"
    #     "-f"
    #     "--adaptive-sync"
    #     "--hdr-enabled"
    #     # Without this, gamescope will automatically attempt to scale
    #     # windows that are rendered at lower resolutions.
    #     #
    #     # This is particularly annoying for launchers.
    #     "--max-scale 1"
    #     # # Ensure that games continue rendering, albeit at a low
    #     # # framerate, even when unfocused. This is required due to
    #     # # xwayland bugs; many games will lose network connection and
    #     # # such if they don't tick regularly.
    #     # "--nested-unfocused-refresh 30"
    #   ];
    # };
  };
}
