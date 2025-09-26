{ pkgs, ... }:

let
  gamingvm_name = "gamingvm0";
  gpu_video = {
    id = "10de:2882";
    location = "52_00_0";
  };
  gpu_audio = {
    id = "10de:22be";
    location = "52_00_1";
  };
in
  let
    gpu_passthrough = pkgs.writeShellScript "gpu_passthrough.sh" ''
      function prepare() {
        echo 0 > /sys/class/vtconsole/vtcon0/bind

        echo efi-framebuffer.0 > /sys/bus/platform/drivers/efi-framebuffer/unbind

        modprobe -r nvidia_drm nvidia_modeset nvidia_uvm nvidia

        virsh nodedev-detach pci_0000_${gpu_video.location}
        virsh nodedev-detach pci_0000_${gpu_audio.location}

        modprobe vfio-pci
      }

      function release() {
        virsh nodedev-reattach pci_0000_${gpu_video.location}
        virsh nodedev-reattach pci_0000_${gpu_audio.location}

        modprobe -r vfio-pci

        echo "efi-framebuffer.0" > /sys/bus/platform/drivers/efi-framebuffer/bind

        modprobe nvidia_drm
        modprobe nvidia_modeset
        modprobe nvidia_uvm
        modprobe nvidia

        echo 1 > /sys/class/vtconsole/vtcon0/bind
      }

      if [ $1 = ${gamingvm_name} ]; then
        case $2 in
          prepare)
            prepare
            ;;
          release)
            release
            ;;
        esac
      fi
    '';
  in {
    virtualisation = {
      libvirtd = {
      enable = true;
      qemu = {
          runAsRoot = true;
          swtpm.enable = true;
          ovmf = {
            enable = true;
            packages = with pkgs; [ OVMFFull.fd ];
          };
        };
        hooks.qemu = {
          #gpu_passthrough = "${gpu_passthrough}";
        };
      };
      containers.enable = true;
      podman.enable = true;
    };

    environment.systemPackages = with pkgs; [ virtiofsd ];
  }