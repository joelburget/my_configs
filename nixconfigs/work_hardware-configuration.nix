# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, pkgs, ... }:

{
  imports =
    [ <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
    ];

  boot.initrd.availableKernelModules = [ "ahci" "ohci_pci" "ehci_pci" "pata_atiixp" ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = { 
      device = "/dev/sda1";
      fsType = "ext4";
      options = "rw,stripe=16,data=ordered,relatime";
    };

  fileSystems."/ceph" = { 
      device = "192.168.0.81:/";
      fsType = "ceph";
      options = "name=admin,secretfile=/root/admin.key";
    };


 swapDevices = [ { 
      device = "/dev/sda2"; 
    } ];

  nix.maxJobs = 2;
}
