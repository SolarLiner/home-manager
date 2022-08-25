{ pkgs ? import <nixpkgs> { } }:
let
  githubVimPlugin = { repo, rev ? "master", sha256 ? "", owner, config ? "", dependencies ? [ ] }:
    {
      plugin = pkgs.vimUtils.buildVimPluginFrom2Nix {
        pname = repo;
        version = rev;
        src = pkgs.fetchFromGitHub {
          inherit owner repo rev sha256;
        };
        inherit dependencies;
      };
      inherit config;
    };
in
with pkgs; {
  vscode-extensions = pkgs.vscode-utils.extensionsFromVscodeMarketplace [
    {
      publisher = "maximedenes";
      name = "vscoq";
      version = "0.3.2";
      sha256 = "sha256-a6URVRu4A3C7zH5Xy2eoyxi358vCGTBhl2LBvtVXpcw=";
    }
    {
      publisher = "equinusocio";
      name = "vsc-material-theme";
      version = "33.1.2";
      sha256 = "sha256-RBhv7EKSvsYkeCkTDU3wETYf4sc4PuZUp2BmBmsHq5E=";
    }
    {
      publisher = "julialang";
      name = "language-julia";
      version = "1.1.25";
      sha256 = "sha256-mb10vEclVhGY+eMpkkpVWRxJxKWpFTlXmp8Te+T4mJY=";
    }
    /*     {
      publisher = "llvm-vs-code-extensions";
      name = "vscode-clangd";
      version = "4.5";
      } */
  ];
  zsh-plugins = [
    {
      name = "zsh-256color";
      file = "zsh-256color.plugin.zsh";
      src = pkgs.fetchFromGitHub {
        owner = "chrissicool";
        repo = "zsh-256color";
        rev = "ae40a49ccfc7520d2d7b575aaea160ff876fe3dc";
        sha256 = "0c2yzbd4y0fyn9yycrxh32am27r0df0x3r526gf1pmyqiv49rg5z";
      };
    }
    /* {
      name = "fast-syntax-highlighting";
      file = "fast-syntax-highlighting.plugin.zsh";
      src = pkgs.fetchFromGitHub {
      owner = "zdharma";
      repo = "fast-syntax-highlighting";
      rev = "5fab542516579bdea5cc8b94137d9d85a0c3fda5";
      sha256 = "1ff1z2snbl9rx3mrcjbamlvc21fh9l32zi2hh9vcgcwbjwn5kikg";
      };
      }
      {
      name = "bullet-train";
      src = builtins.fetchTarball {
      url = "https://github.com/caiogondim/bullet-train.zsh/archive/master.tar.gz";
      };
      file = "bullet-train.zsh-theme";
      } */
  ];
}
