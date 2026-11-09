{ pkgs, inputs, ... }:

{
  imports = [
    # hardware
    inputs.nixos-hardware.nixosModules.asus-zephyrus-ga401
    ./hardware-configuration.nix

    # disko
    inputs.disko.nixosModules.disko
    ./disko.nix

    # modules
    ../../modules/nixos/zsh.nix
    ../../modules/nixos/kanata.nix

    # Home Manager
    inputs.home-manager.nixosModules.home-manager
    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;

        extraSpecialArgs = {
          inherit inputs;
        };

        users.arman = ./home-arman.nix;
      };
    }
  ];

  users = {
    # Users
    users.arman = {
      isNormalUser = true;
      group = "arman";
      extraGroups = [
        "wheel"
        "networkmanager"
      ];
    };

    # Groups
    groups.arman = { };
  };

  # System profile packages
  environment.systemPackages = with pkgs; [
    vim
    pciutils
  ];

  # Networking
  networking.hostName = "suzaku";
  networking.networkmanager.enable = true;

  # Time zone.
  time.timeZone = "Asia/Tehran";

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Input devices
  services.libinput.enable = true;

  # Audio
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  # Hardware
  hardware.enableRedistributableFirmware = true;

  # Nix
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "26.05";
}
