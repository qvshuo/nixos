{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./imports/boot.nix
      ./imports/de.nix
      ./imports/hardware.nix
      ./imports/localization.nix
      ./imports/user.nix
    ];

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
    alacritty
    clash
    fish
    hugo
    git
    manpages
    neofetch
    neovim
    nodejs
    proxychains
    scrcpy
    texinfo
    you-get
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

