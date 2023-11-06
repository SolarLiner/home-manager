{pkgs, lib,...}:
{
  programs.git = {
    package = pkgs.gitAndTools.gitFull;
    enable = true;
    difftastic.enable = true;
    lfs.enable = true;
    userName = "Nathan Graule";
    userEmail = lib.mkDefault "solarliner@gmail.com";
    extraConfig = {
      fetch.prune = true;
    };
  };
  programs.gh = {
    enable = lib.mkDefault true;
    settings = {
      prompt = "enabled";
      git_protocol = "ssh";
    };
  };
}