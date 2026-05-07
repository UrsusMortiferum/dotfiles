{ self, ... }:
{
  flake.nixosModules.core =
    {
      config,
      pkgs,
      lib,
      inputs,
      outputs,
      ...
    }:
    {
      imports = [
        self.nixosModules.nix
        self.nixosModules.locale
        self.nixosModules.network
      ];
      nix.optimise = {
        automatic = true;
        dates = [ "16:00" ]; # Daily at 4PM, if not, then on boot
      };
      nix.settings = {
        auto-optimise-store = true;
        substituters = [
          "https://nix-community.cachix.org"
          "https://hyprland.cachix.org"
        ];
        trusted-substituters = [ ];
        trusted-public-keys = [
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
          "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        ];
      };

      boot = {
        kernelPackages = pkgs.linuxPackages_latest;

        loader = {
          systemd-boot.enable = true;
          efi.canTouchEfiVariables = true;
        };

        plymouth = {
          enable = true;
          theme = "rings";
          themePackages = with pkgs; [
            # By default we would install all themes
            (adi1090x-plymouth-themes.override {
              selected_themes = [ "rings" ];
            })
          ];
        };

        # Enable "Silent boot"
        consoleLogLevel = 3;
        initrd.verbose = false;
        kernelParams = [
          "quiet"
          "udev.log_level=3"
          "systemd.show_status=auto"
        ];
        # Hide the OS choice for bootloaders.
        # It's still possible to open the bootloader list by pressing any key
        # It will just not appear on screen unless a key is pressed
        loader.timeout = 0;

        initrd.systemd.enable = true;
      };
    };

}
