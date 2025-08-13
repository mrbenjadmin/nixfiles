## Directory Structure
├── flake.lock          # pinning inputs
├── flake.nix           # 
│
├── machines            # machine-specific configuration
    └── ${host}
        ├── default.nix # 
        ├── hardware-configuration.nix # bare minimum to boot into a working install
                                       # maybe look into testing for specific role for hardware-specific 

layout:
 - heterogeneous cluster of machines at home
   - 1 main router(likely honeycomb lx2) running wireguard for offsite communication, otherwise ethernet
   - 1 gigabit ethernet connection on most servers, 10gbe on anything that needs fast storage(anything with good GPU as those will run VMs)
     - ensure nvme ssds are controlled separate from slower drives for VM and cache usage

things each machine needs that is currently determined at or after deployment:
 - /etc/machine-id
   - store in nix store
   - derive via `uuidgen -r | tr -d -`
 - network hostId
   - derive from `/etc/machine-id` via `head -c8 /etc/machine-id`
 - ssh keysets
 - nebula certs
 - disks
 - ip address
   - public
   - local
   - vpn
 - available interfaces
 - wireguard keys(for routers)

TODO:
 - estimate disk space required for cluster machines to run and maintain up to 5 previous generations for dedicated boot/root disks
 - central log server with journald
 - central metric server with prometheus
 - LXC or kubernetes for dev containers
   - dedicated job orchestration?
 - distcc?
 - distributed nix builds across servers
 - local nginx
 - custom dns
   - geoip
 - local DNS override for local server access
   - NAT hairpinning would make debugging from home difficult due to being unable to access the server by addressing it via IP directly and seems more difficult to set up
 - ipv6?
 - load balancing
 - offsite backups
   - S3 in the cloud?
 - cloud S3 for storage overflow?
 - distributed sql(postgres?) and cache db(redis?)
 - router replacement?
 - media servers(rpi3b+ and odroid n2+)
 - automatic transcoding into efficient h.265 for all incoming media
 - automatic (re)compression for all incoming compressible data
 - full disk encryption for laptops
   - OPAL?
 - secure boot for all supported devices
 - impermanence for all devices
 - wizard for spinning up clusters of test VMs of arbitrary OS/distro