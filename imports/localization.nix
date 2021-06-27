{ config, pkgs, ... }:

{
  # Set time zone.
  time.timeZone = "Asia/Shanghai";

  # Language and input method.
  i18n = {
    defaultLocale = "en_US.UTF-8";
    inputMethod = {
      enabled = "ibus";
      ibus.engines = with pkgs.ibus-engines; [ rime ];
    };
  };
}
