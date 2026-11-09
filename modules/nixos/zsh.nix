{ pkgs, ... }:

{
  users.defaultUserShell = pkgs.zsh;

  programs.zsh = {
    enable = true;

    enableCompletion = true;

    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;

    histSize = 10000;

    setOptions = [
      "EXTENDED_HISTORY"
      "HIST_IGNORE_DUPS"
      "HIST_IGNORE_SPACE"
      "HIST_FCNTL_LOCK"
      "SHARE_HISTORY"
    ];

    interactiveShellInit = ''
      # Emacs editing mode.
      bindkey -e

      # Make word boundaries closer to Emacs.
      WORDCHARS=""

      # M-f should move to the end of a word, as in Emacs.
      bindkey '^[f' emacs-forward-word
      bindkey '^[b' backward-word
    '';

    promptInit = ''
      if [[ $TERM != dumb ]]; then
        fpath=(${pkgs.pure-prompt}/share/zsh/site-functions $fpath)

        autoload -Uz promptinit
        promptinit
        prompt pure
      fi
    '';
  };
}
