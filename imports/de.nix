{ config, pkgs, ... }:

{
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.displayManager.gdm.enable = true;

  services.gnome.core-utilities.enable = false;

  environment.systemPackages = with pkgs.gnome; [

  ];
}
