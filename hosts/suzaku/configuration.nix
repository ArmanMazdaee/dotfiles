{ pkgs, ... }:

{
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Nix
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nixpkgs.config.allowUnfree = true;

  # Hardware
  hardware.enableRedistributableFirmware = true;

  # Time zone.
  time.timeZone = "Asia/Tehran";

  # Networking
  networking.hostName = "suzaku";
  networking.networkmanager.enable = true;

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

  # TODO: Move to the home manager

  # System profile packages
  environment.systemPackages = with pkgs; [
    vim
    pciutils
  ];

  system.stateVersion = "26.05";
}
