{
  programs.git = {
    enable = true;
    settings = {
      user.email = "ar.mazdaee@gmail.com";
      user.name = "Arman Mazdaee";
      push.autoSetupRemote = true;
    };
    ignores = [
      ".dir-locals.el"
    ];
  };
}
