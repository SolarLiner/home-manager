{ pkgs, ... }:
{
  home.packages = with pkgs; [kmail];

  accounts.email = {
    accounts = {
      "solarliner@gmail.com" = {
        address = "solarliner@gmail.com";
        realName = "Nathan Graule";
        primary = true;
        thunderbird.enable = true;
      };
    };
  };
  programs.thunderbird = {
    enable = true;
    profiles = {
      default = {
        isDefault = true;
      };
    };
  };
}
