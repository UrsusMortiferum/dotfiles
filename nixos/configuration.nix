{
  config,
  pkgs,
  lib,
  inputs,
  outputs,
  hostName,
  ...
}:

{
  imports = [
    ./hosts/default.nix
  ];

  nix.optimise = {
    automatic = true;
    dates = [ "00:00" ]; # Optional; allows customizing optimisation schedule
  };
  nix.settings = {
    substituters = [
      "https://nix-community.cachix.org"
      "https://hyprland.cachix.org"
    ];
    trusted-substituters = [ ];
    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
    ];
    auto-optimise-store = true;
    experimental-features = [
      "nix-command"
      "flakes"
      "pipe-operators"
    ];
  };

  nixpkgs.overlays = [
    outputs.overlays.additions
    outputs.overlays.modifications
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # networking.hostName = "cave"; # Define your hostname.
  networking.hostName = hostName;
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
        "libvirtd"
      ];
      packages = with pkgs; [ ];
      initialPassword = "nixos";
    };
    root = {
      initialPassword = "nixos";
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
    amdgpu_top
    proton-vpn
    ghostty
    stow
    inputs.zen-browser.packages.${system}.twilight
    wl-clipboard
    wl-screenrec
    font-awesome
    uv
    nerd-fonts.victor-mono
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
    nixfmt
    pavucontrol
    tree
    proton-pass
    discord
    bootdev-cli
    hyprpaper
    brightnessctl # for gpd brightness adjustment
    quickemu
    bat
    go # think about this once config is rewritten
    obsidian
    hyprlauncher
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
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage =
      inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
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
  };

  programs.starship = {
    enable = true;
    presets = [ "jetpack" ];
  };

  programs.nano.enable = false;

  stylix.enable = true;
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark.yaml";
  stylix.cursor = {
    # package = pkgs.capitaine-cursors-themed;
    # name = "Gruvbox";
    package = pkgs.banana-cursor-dreams;
    name = "Banana-Tokyo-Night-Storm";
    size = 32;
  };
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
            pkgs.mpv.override {
              scripts = with pkgs.mpvScripts; [ uosc ];
              # mpv = pkgs.mpv.override { waylandSupport = true; };
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

  services.udev.enable = true;
  system.autoUpgrade = {
    enable = true;
    allowReboot = false;
    dates = "weekly";
  };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  programs.ssh.startAgent = true;

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

  services.udisks2.enable = true;
  programs.thunar.enable = true;
  services.gvfs.enable = true;

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
  hardware.amdgpu.initrd.enable = true;
  hardware.cpu.amd.updateMicrocode = true;
  hardware.firmware = [ pkgs.linux-firmware ];
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      mesa
    ];
    extraPackages32 = with pkgs; [
      driversi686Linux.mesa
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

  # virtualisation.libvirtd.enable = true;
  # programs.virt-manager.enable = true;
  # services.samba = {
  #   enable = true;
  #   openFirewall = false;
  #   settings = {
  #     global = {
  #       security = "user";
  #       "map to guest" = "never";
  #       "server min protocol" = "SMB2";
  #     };
  #
  #     ms_slop = {
  #       path = "/home/ursus/workspace/local/ms_slop/data";
  #       browseable = "yes";
  #       "read only" = "no";
  #       "guest ok" = "no";
  #       "valid users" = "ursus";
  #       "create mask" = "0664";
  #       "directory mask" = "0775";
  #     };
  #   };
  # };
  #
  # virtualisation.docker.enable = true;
  # systemd.services.docker = {
  #   after = [ "network-online.target" ];
  #   wants = [ "network-online.target" ];
  # };

}
