{ config, pkgs, lib, ... }:
let
  inherit (lib) mkIf;
  isWSL = config.home.username != "solarliner";
  zsh-256color = rec {
    name = "zsh-256color";
    file = "${name}.plugin.zsh";
    src = pkgs.fetchFromGitHub {
      repo = "zsh-256color";
      owner = "chrissicool";
      rev = "9d8fa1015dfa895f2258c2efc668bc7012f06da6";
      sha256 = "Qd9pjDSQk+kz++/UjGVbM4AhAklc1xSTimLQXxN57pI=";
    };
  };
  zsh-autopair = {
    inherit(pkgs.zsh-autopair) name src;
    file = "autopair.plugin.zsh";
  };
  zsh-you-should-use = {
    inherit(pkgs.zsh-you-should-use) name src;
    file = "you-should-use.plugin.zsh";
  };
  zsh-vi-mode = {
    inherit(pkgs.zsh-vi-mode) name src;
    file = "you-should-use.plugin.zsh";
  };
in
{
  programs.autojump.enable = true;
  programs.bat.enable = true;
  programs.eza = {
    enable = true;
    enableAliases = true;
  };
  programs.bash.enable = false;
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
  programs.nushell = {
    enable = true;
    envFile = {
      text = ''
        mkdir ~/.cache/starship
        starship init nu | save ~/.cache/starship/init.nu
      '';
    };
    configFile = {
      text = ''
        source ~/.cache/starship/init.nu
      '';
    };
  };
  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    syntaxHighlighting.enable = true;
    plugins = [ zsh-256color zsh-autopair zsh-you-should-use zsh-vi-mode ];
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "sudo" "rust" "autojump" "vscode" ];
      extraConfig = ''
        export NIX_PATH=$HOME/.nix-defexpr/channels''${NIX_PATH:+:}$NIX_PATH
        export PATH=$HOME/.nix-profile/bin:$PATH

        alias zr="zellij run --"
        alias ze="zellij edit --"
        alias za="zellij action"
      '';
    };
  };
  systemd.user.services =
    let mkFuseService = { description, exec, folder }: {
      Unit = {
        Description = description;
        After = ["network.target"];
      };
      Install.WantedBy = ["default.target"];
      Service = {
        ExecStartPre = "mkdir -p '${folder}'";
        ExecStart = "${exec folder}";
        ExecStop = "fusermount -u '${folder}'";
        ExecStopPost = "rmdir '${folder}' || exit 0";
        Restart = "always";
        Type = "forking";
      };
    };
    in mkIf (!isWSL) {
      google-drive-ocamlfuse = mkFuseService {
        description = "Google Drive FUSE mount";
        exec = folder: "${pkgs.google-drive-ocamlfuse}/bin/google-drive-ocamlfuse '${folder}'";
        folder = "%h/Google Drive";
      };
  };
}
