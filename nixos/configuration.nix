{
  config,
  pkgs,
  lib,
  inputs,
  outputs,
  hostName,
  ...
}: {
  imports = [
    ./modules/locale.nix
    ./modules/nh.nix
    ./modules/nix.nix
    ./modules/hosts/default.nix
  ];

  nixpkgs.overlays = [
    outputs.overlays.additions
    outputs.overlays.modifications
  ];

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
      packages = with pkgs; [];
      initialPassword = "nixos";
    };
    root = {
      initialPassword = "nixos";
    };
  };

  # programs.bash = {
  #   interactiveShellInit = ''
  #     if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
  #     then
  #       shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
  #       exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
  #     fi
  #   '';
  # };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wget
    curl
    amdgpu_top
    proton-vpn
    ghostty
    stow
    inputs.helium.packages.${stdenv.hostPlatform.system}.default
    wl-clipboard
    wl-screenrec
    uv
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
    # screenshots
    grim
    slurp
    swappy
    # noctalia-shell
    proton-pass-cli
    # docker
    pcmanfm
    zellij
    tmux
    awscli2
    kubectl
    minikube
    # btop
    emacs
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.victor-mono
    font-awesome
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

  # programs.fish = {
  #   enable = true;
  # };

  # programs.waybar = {
  #   enable = true;
  # };

  programs.gamescope = {
    enable = true;
    # capSysNice = true;
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

  # programs.starship = {
  #   enable = true;
  #   presets = ["jetpack"];
  # };

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
    packages = [pkgs.dunst];
  };

  # Thunar + automounting
  # services.udisks2.enable = true;
  # programs.thunar.enable = true;
  # services.gvfs.enable = true;
  # services.udisks2.enable = true;
  # services.devmon.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  services.xserver.videoDrivers = ["amdgpu"];
  hardware.amdgpu.initrd.enable = true;
  hardware.cpu.amd.updateMicrocode = true;
  hardware.firmware = [pkgs.linux-firmware];
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
    # enableFishIntegration = true;
    enableZshIntegration = true;
    flags = ["--cmd cd"];
  };

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
  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
    autoPrune.enable = true;
  };

  programs.dms-shell = {
    enable = true;
    package = inputs.dms.packages.${pkgs.stdenv.hostPlatform.system}.default;
    systemd = {
      enable = true;
      restartIfChanged = true;
    };
    enableSystemMonitoring = true;
    enableVPN = true;
    enableAudioWavelength = true;
    enableClipboardPaste = true;
  };

  # systemd.services.docker = {
  #   after = [ "network-online.target" ];
  #   wants = [ "network-online.target" ];
  # };
}
