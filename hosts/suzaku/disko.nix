# DANGER: Disko will DESTROY the partition table and data on the selected disk.
# Replace the by-id path below after inspecting `lsblk` and /dev/disk/by-id.
# This is a filesystem reformat, NOT a forensic/NVMe secure erase.
{
  disko.devices = {
    disk.main = {
      type = "disk";
      device = "/dev/disk/by-id/nvme-HFM001TD3JX013N_CY0CN03971120CJ1B";
      content = {
        type = "gpt";
        partitions = {
          ESP = {
            priority = 1;
            size = "2G";
            type = "EF00";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
              mountOptions = [ "umask=0077" ];
            };
          };

          luks = {
            size = "100%";
            content = {
              type = "luks";
              name = "cryptroot";
              extraFormatArgs = [
                "--type"
                "luks2"
              ];
              # Interactive passphrase during initial Disko formatting.
              # Permit periodic SSD TRIM through encryption; this leaks some
              # information about allocated blocks, not plaintext contents.
              settings.allowDiscards = true;
              content = {
                type = "lvm_pv";
                vg = "vg0";
              };
            };
          };
        };
      };
    };

    lvm_vg.vg0 = {
      type = "lvm_vg";
      lvs = {
        swap = {
          size = "32G";
          content = {
            type = "swap";
            # Must stay persistent, NOT randomly re-encrypted on every boot.
            resumeDevice = true;
          };
        };

        root = {
          size = "100%FREE";
          content = {
            type = "btrfs";
            extraArgs = [ "-f" ];
            subvolumes = {
              "/@root" = {
                mountpoint = "/";
                mountOptions = [
                  "compress=zstd:1"
                  "noatime"
                ];
              };
              "/@home" = {
                mountpoint = "/home";
                mountOptions = [
                  "compress=zstd:1"
                  "noatime"
                ];
              };
              "/@nix" = {
                mountpoint = "/nix";
                mountOptions = [
                  "compress=zstd:1"
                  "noatime"
                ];
              };
              "/@log" = {
                mountpoint = "/var/log";
                mountOptions = [
                  "compress=zstd:1"
                  "noatime"
                ];
              };
            };
          };
        };
      };
    };
  };
}
