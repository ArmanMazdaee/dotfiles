{ inputs }:

let
  inherit (inputs) nixpkgs home-manager disko nixos-hardware;
in
nixpkgs.lib.nixosSystem {
  system = "x86_64-linux";

  specialArgs = {
    inherit inputs;
  };

  modules = [
    # External modules
    disko.nixosModules.disko
    nixos-hardware.nixosModules.asus-zephyrus-ga401
    home-manager.nixosModules.home-manager

    # Host configuration
    ./configuration.nix
    ./hardware-configuration.nix
    ./disko.nix

    # Local modules
    ../../modules/nixos/zsh.nix

    # Home Manager
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

    {
      users = {
        # Users
        users.arman = {
          isNormalUser = true;
          group = "arman";
          extraGroups = [ "wheel" "networkmanager" ];
        };

        # Groups
        groups.arman = {};
      };
    }
  ];
}
