{ config, lib, pkgs, ... }:
with lib.lists;
let
  isWSL = config.home.username == "nixos";
in {
  home.packages = with pkgs; optionals (!isWSL) [kmail];

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
    enable = !isWSL;
    profiles = {
      default = {
        isDefault = true;
      };
    };
  };
}
