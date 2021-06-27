{ config, pkgs, ... }:

{
  # Define a user account.
  users.users.huizhi = {
    isNormalUser = true;
    home = "/home/huizhi";
    extraGroups = [ "wheel" "networkmanager" ];
    description = "杨蕙芷";
    uid = 1000;
  };

  # Users of the wheel group must provide a password to run commands as super user via sudo. 
  security.sudo.wheelNeedsPassword = false; 
}
