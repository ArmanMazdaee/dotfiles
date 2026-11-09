{ pkgs, ... }:

{
  imports = [
    ../../modules/home/git.nix
    ../../modules/home/niri.nix
    ../../modules/home/noctalia.nix
  ];

  home.username = "arman";
  home.homeDirectory = "/home/arman";

  home.sessionVariables = {
    EDITOR = "emacs";
  };

  home.packages = with pkgs; [
    git
    ripgrep
    emacs
    curl
    aria2
  ];

  programs.firefox.enable = true;

  programs.home-manager.enable = true;

  home.stateVersion = "26.05";
}
