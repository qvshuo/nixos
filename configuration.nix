{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./imports/gdm.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable Plymouth boot splash screen.
  boot.plymouth.enable = true;

  # Update the CPU microcode for Intel processors.
  hardware.cpu.intel.updateMicrocode = true;

  # GPU acceleration.
  hardware.opengl.extraPackages = with pkgs; [
    intel-compute-runtime
  ];

  # Enable Font/DPI configuration optimized for HiDPI displays.
  hardware.video.hidpi.enable = true;

  # Enable pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };


  # Use hardware clock in local time instead of UTC.
  time.hardwareClockInLocalTime = true;

  # Set time zone.
  time.timeZone = "Asia/Shanghai";

  # Language and input method.
  i18n = {
    defaultLocale = "en_US.UTF-8";
    inputMethod = {
      enabled = "ibus";
      ibus.engines = with pkgs.ibus-engines; [
        rime
      ];
    };
  };

  # Enable the X server.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Packages excluded from the default environment.
  environment.gnome.excludePackages =  with pkgs.gnome; [
    baobab
    cheese
    epiphany
    gedit
    gnome-calculator
    gnome-calendar
    gnome-characters
    gnome-clocks
    gnome-contacts
    gnome-font-viewer
    gnome-logs
    gnome-maps
    gnome-music
    pkgs.gnome-photos
    gnome-screenshot
    gnome-system-monitor
    gnome-weather
    pkgs.gnome-connections
    simple-scan
    totem
    yelp
  ];

  # User.
  users.users.huizhi = {
    isNormalUser = true;
    home = "/home/huizhi";
    extraGroups = [ "wheel" "networkmanager" ];
    description = "YHZ";
    uid = 1000;
  };
  security.sudo.wheelNeedsPassword = false;


  # Garbage collector.
  nix.gc.automatic = true;
  nix.gc.dates = "05:00";
  nix.gc.options = "--delete-older-than 7d";


  # List of binary cache URLs used to obtain pre-built binaries of Nix packages.
  nix.binaryCaches = [ "https://mirror.sjtu.edu.cn/nix-channels/store" ];

  # Allow unfree.
  nixpkgs.config.allowUnfree = true;

  # The set of packages that appear in /run/current-system/sw.
  environment.systemPackages = with pkgs; [
    clash
    firefox
    fish
    hugo
    git
    neofetch
    neovim
    proxychains
    vscode
  ];

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Disable the firewall.
  networking.firewall.enable = false;

  # Enable flatpak.
  services.flatpak.enable = true;

  # The NixOS release.
  system.stateVersion = "21.05";

}

