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
        self.nixosModules.network
      ];

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
