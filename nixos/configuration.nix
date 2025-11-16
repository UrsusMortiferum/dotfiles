# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

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
    # Include the results of the hardware scan.
    ./hosts/cave/configuration.nix
    # ./hardware-configuration.nix
    ./vial.nix
    # ./vpn.nix
  ];

  nix.optimise = {
    automatic = true;
    dates = [ "00:00" ]; # Optional; allows customizing optimisation schedule
  };
  # nix.gc = {
  #   automatic = true;
  #   dates = "weekly";
  #   options = "--delete-older-than 15d";
  # };
  nix.settings = {
    auto-optimise-store = true;
    experimental-features = [
      "nix-command"
      "flakes"
      "pipe-operators"
    ];
  };

  nixpkgs.overlays = [ outputs.overlays.additions ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  # nixpkgs.config.permittedInsecurePackages = [ "qtwebengine-5.15.19" ];

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
  users.users = {
    ursus = {
      isNormalUser = true;
      description = "ursus";
      extraGroups = [
        "networkmanager"
        "wheel"
        "docker"
      ];
      packages = with pkgs; [ ];
    };
  };

  programs.bash = {
    interactiveShellInit = ''
      if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
      then
        shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
        exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
      fi
    '';
  };

  environment.sessionVariables = {
    # FLAKE = "/home/ursus/workspace/github.com/UrsusMortiferum/dotfiles/nixos";
  };

  programs.nh = {
    enable = true;
    flake = "/home/ursus/workspace/github.com/UrsusMortiferum/dotfiles/nixos";
    # Options only for automatic cleanup.
    clean.enable = true;
    clean.dates = "weekly";
    clean.extraArgs = "--keep-since 15d --keep 15";
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    curl
    # amdvlk
    amdgpu_top
    protonvpn-gui
    ghostty
    stow
    inputs.zen-browser.packages.${system}.twilight
    # inputs.vieb-nix.packages.${system}.vieb
    wl-clipboard
    wl-screenrec
    font-awesome
    uv
    nerd-fonts.victor-mono
    # jellyfin-media-player
    docker-compose
    quickshell
    wofi
    clang
    signal-desktop
    lazygit
    ripgrep
    fzf
    rustup
    nil
    # nixd
    pavucontrol
    # element-web
    tree
    heroic
    # banana-cursor-dreams
    ranger
    superfile
    samrewritten
    heroic
    proton-pass
    # kdePackages.dolphin
    # protontricks
    # wine
    # wine64
    # wineWowPackages.staging
    # winetricks
    # wineWowPackages.waylandFull
    # protontricks
    # steamtinkerlaunch
    # ashell
    discord
    # nexusmods-app-unfree
    # freetype
    # (python3.withPackages (ps: [ ps.tkinter ]))
    # firefox
  ];

  fonts.packages = with pkgs; [ nerd-fonts.victor-mono ];

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

  programs.fish = {
    enable = true;
  };

  programs.waybar = {
    enable = true;
  };

  programs.gamescope = {
    enable = true;
    capSysNice = true;
  };

  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
    protontricks.enable = true;
    extraCompatPackages = with pkgs; [
      proton-ge-bin
      steamtinkerlaunch
      protonup-qt
      freetype
      fontconfig
      protontricks
    ];

    # extraPackages = with pkgs; [ freetype fontconfig ];
    # steamtinkerlaunch.enable = true;
    # package = pkgs.steam.override {
    #   extraPkgs =
    #     pkgs': with pkgs'; [
    #       steamtinkerlaunch
    #       proton-ge-bin
    #       protonup-qt
    #       freetype
    #       fontconfig
    #       glib
    #       libunwind
    #       libxcb
    #       # protontricks
    #     ];
    # };
  };
  # programs.steam.protontricks.enable = true;

  programs.starship = {
    enable = true;
    presets = [ "jetpack" ];
  };

  programs.nano.enable = false;

  stylix.enable = true;
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-dark.yaml";
  stylix.cursor = {
    # package = pkgs.banana-cursor;
    # package = pkgs.inputs.banana-cursor.packages.${system}.banana-cursor;
    # package = pkgs.banana-cursor-dreams;
    package = pkgs.banana-cursor-dreams;
    name = "Banana-Tokyo-Night-Storm";
    size = 32;
  };
  # stylix.autoEnable = false;
  # stylix.targets = {
  #   btop.enable = true;
  #   fish.enable = true;
  #   fzf.enable = true;
  #   ghostty.enable = true;
  #   lazygit.enable = true;
  # };
  # stylix.base16Scheme = {
  #   base00 = "15161e";
  #   base01 = "f7768e";
  #   base02 = "9ece6a";
  #   base03 = "e0af68";
  #   base04 = "7aa2f7";
  #   base05 = "bb9af7";
  #   base06 = "7dcfff";
  #   base07 = "a9b1d6";
  #   base08 = "414868";
  #   base09 = "ff899d";
  #   base0A = "9fe044";
  #   base0B = "faba4a";
  #   base0C = "8db0ff";
  #   base0D = "c7a9ff";
  #   base0E = "a4daff";
  #   base0F = "c0caf5";
  # };
  stylix.polarity = "dark";

  home-manager = {
    users = {
      ursus = {
        home.stateVersion = "25.05";
        imports = [ ./btop.nix ];
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
              scripts = with pkgs.mpvScripts; [ uosc ];

              mpv = pkgs.mpv-unwrapped.override { waylandSupport = true; };
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

  services.udev.enable = true;
  system.autoUpgrade = {
    enable = true;
    allowReboot = false;
    dates = "weekly";
  };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  services.displayManager = {
    sddm = {
      enable = true;
      wayland.enable = true;
      enableHidpi = true;
      theme = "breeze";
    };
  };

  services.dbus = {
    enable = true;
    packages = [ pkgs.dunst ];
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

  services.xserver.videoDrivers = [ "amdgpu" ];
  # boot.initrd.kernelModules = [ "amdgpu" ];
  hardware.amdgpu.initrd.enable = true;
  hardware.cpu.amd.updateMicrocode = true;
  hardware.firmware = [ pkgs.linux-firmware ];
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      mesa
      # amdvlk
    ];
    extraPackages32 = with pkgs; [
      driversi686Linux.mesa
      # driversi686Linux.amdvlk
    ];
  };
  hardware.enableRedistributableFirmware = true;
  programs.xwayland.enable = true;
  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    enableZshIntegration = true;
    flags = [ "--cmd cd" ];
  };

  programs.nix-ld.enable = true;

  virtualisation.docker.enable = true;

}
