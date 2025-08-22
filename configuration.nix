# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./vial.nix
    # ./vpn.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "cave"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pl_PL.UTF-8";
    LC_IDENTIFICATION = "pl_PL.UTF-8";
    LC_MEASUREMENT = "pl_PL.UTF-8";
    LC_MONETARY = "pl_PL.UTF-8";
    LC_NAME = "pl_PL.UTF-8";
    LC_NUMERIC = "pl_PL.UTF-8";
    LC_PAPER = "pl_PL.UTF-8";
    LC_TELEPHONE = "pl_PL.UTF-8";
    LC_TIME = "pl_PL.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ursus = {
    isNormalUser = true;
    description = "ursus";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    packages = with pkgs; [ ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    curl
    amdvlk
    amdgpu_top
    protonvpn-gui
    ghostty
    stow
    inputs.zen-browser.packages.${system}.twilight
    wl-clipboard
    wl-screenrec
    font-awesome
    uv
    nerd-fonts.victor-mono
    jellyfin-media-player
    docker-compose
    quickshell
    wofi
    clang
    signal-desktop
    discord
    lazygit
    ripgrep
    fzf
    rustup
    nil
    pavucontrol
    element-web
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.victor-mono
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  programs.git = {
    enable = true;
    config = {
      user.name = "UrsusMortiferum";
      user.email = "101043729+UrsusMortiferum@users.noreply.github.com";
      init.defaultBranch = "main";
      # pull.rebase = true;
      # core.editor = "nvim"
    };
  };

  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland = {
      enable = true;
    };
  };

  programs.waybar = {
    enable = true;
  };

  programs.steam = {
    enable = true;
  };

  programs.nano.enable = false;

  home-manager = {
    users = {
      ursus = {
        home.stateVersion = "25.05";
        imports = [
          ./btop.nix
        ];
      };
    };
    backupFileExtension = "backup";
  };

  home-manager.sharedModules = [
    (
      { config, pkgs, ... }:
      {
        programs.mpv = {
          enable = true;
          package = (
            pkgs.mpv-unwrapped.wrapper {
              scripts = with pkgs.mpvScripts; [
                uosc
              ];

              mpv = pkgs.mpv-unwrapped.override {
                waylandSupport = true;
              };
            }
          );
          config = {
            profile = "high-quality";
            cache-default = 4000000;
          };
        };
        services.dunst = {
          enable = true;
        };
      }
    )
  ];

  # List services that you want to enable:
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  # services.udev = {
  #   packages = with pkgs; [
  #     qmk-udev-rules
  #     vial
  #   ];
  # };

  nix.optimise = {
    automatic = true;
    dates = [ "00:00" ]; # Optional; allows customizing optimisation schedule
  };
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 15d";
  };
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = false;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  services = {
    displayManager = {
      sddm = {
        enable = true;
        wayland.enable = true;
        enableHidpi = true;
        theme = "chili";
      };
    };
    dbus = {
      enable = true;
      packages = [ pkgs.dunst ];
    };
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

  boot.initrd.kernelModules = [ "amdgpu" ];
  services.xserver.videoDrivers = [ "amdgpu" ];
  hardware.cpu.amd.updateMicrocode = true;
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      mesa
      amdvlk
    ];
    extraPackages32 = with pkgs; [
      driversi686Linux.mesa
      driversi686Linux.amdvlk
    ];
  };
  hardware.enableRedistributableFirmware = true;
  programs.xwayland.enable = true;

}
