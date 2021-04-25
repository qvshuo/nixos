{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Set time zone.
  time.timeZone = "Asia/Shanghai";

  # Localization.
  i18n = {
    defaultLocale = "zh_CN.UTF-8";
    extraLocaleSettings =  { LC_TIME = "en_US.UTF-8"; };
    supportedLocales = [ "zh_CN.UTF-8/UTF-8" "ja_JP.UTF-8/UTF-8" "en_US.UTF-8/UTF-8" ];
    inputMethod = {
      enabled = "ibus";
      ibus.engines = with pkgs.ibus-engines; [ libpinyin mozc ];
    };
  };

  # Define hostname.
  networking.hostName = "nixos";

  # Define a user account.
  users.users.huizhi = {
    isNormalUser = true;
    home = "/home/huizhi";
    extraGroups = [ "wheel" "networkmanager" ];
    description = "杨蕙芷";
    uid = 1000;
  };

  # Whether users of the wheel group must provide a password to run commands as super user via sudo. 
  security.sudo.wheelNeedsPassword = false; 

  # Enable Font/DPI configuration optimized for HiDPI displays.
  hardware.video.hidpi.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Configure keymap in X11
  services.xserver.layout = "us";

  # Fonts.
  fonts = {
    enableDefaultFonts = true;
    fontconfig = {
      defaultFonts.monospace = [ "Sarasa Mono SC" ];
      defaultFonts.sansSerif = [ "Sarasa Gothic SC" ];
      defaultFonts.serif = [ "Source Han Serif SC" ];
    };
      fonts = with pkgs; [
        sarasa-gothic
        source-han-serif
      ];
  };
  
  # Enable the Pantheon Desktop Environment.
  services.xserver.desktopManager.pantheon.enable = true;

  # Which packages pantheon should exclude from the default environment.
  environment.pantheon.excludePackages = with pkgs; [
    pkgs.pantheon.elementary-camera
  ];

  services.system-config-printer.enable = false;

  # Enable xdg desktop integration.
  xdg.portal.enable = true;
  # List of additional portals to add to path.
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  # A set of environment variables used in the global environment.
  environment.variables = { EDITOR = "nvim"; VISUAL = "nvim"; };

  # Update the CPU microcode for Intel processors.
  hardware.cpu.intel.updateMicrocode = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Video drivers
  services.xserver.videoDrivers = [ "modesetting" ];

  #  Enable the TLP power management daemon.
  services.tlp.enable = true;

  # Whether to enable periodic SSD TRIM of mounted partitions in background.
  services.fstrim.enable = true;

  # Garbage collector.
  nix.gc.automatic = true;
  nix.gc.dates = "03:15";
  nix.gc.options = "--delete-older-than 7d";

  # List of binary cache URLs used to obtain pre-built binaries of Nix packages.
  nix.binaryCaches = [ "https://mirrors.bfsu.edu.cn/nix-channels/store" ];

  # Allow unfree.
  nixpkgs.config.allowUnfree = true;

  # The set of packages that appear in /run/current-system/sw.
  environment.systemPackages = with pkgs; [
    clash
    dosfstools
    drawio
    firefox
    fish
    hugo
    gimp
    git
    manpages
    neofetch
    neovim
    nodejs
    proxychains
    scrcpy
    tdesktop
    texinfo
    typora
    unixtools.xxd
    you-get
  ];

  # Whether to enable the Vixie cron daemon.
  services.cron.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.openssh.ports = [ 8765 ];

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 7890 8765 ];
  networking.firewall.allowedUDPPorts = [ 7890 8765 ];

  # The NixOS release.
  system.stateVersion = "20.09";
}

