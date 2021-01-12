resource "proxmox_lxc" "lxc" {
  target_node = local.proxmox_node
  pool        = local.proxmox_resource_pool

  ostemplate = local.os_template
  ostype     = local.os_type
  arch       = local.arch

  vmid            = local.id
  hostname        = local.name
  password        = local.password
  ssh_public_keys = <<-EOF
  %{for key in local.public_ssh_keys~}
  ${key}
  %{endfor~}
EOF

  unprivileged = local.unprivileged
  onboot       = local.start_on_boot
  start        = local.start_on_create
  protection   = false

  features {
    fuse    = local.enable_fuse
    keyctl  = local.enable_keyctl
    mount   = local.mount_types
    nesting = local.enable_nesting
  }

  cores  = local.cores
  memory = local.memory
  swap   = local.swap_memory

  // Terraform will crash without rootfs defined
  rootfs {
    storage = local.rootfs_storage_volume
    size    = format("%sG", local.rootfs_size_gb)
  }

  dynamic "mountpoint" {
    for_each = local.mount_points

    content {
      mp      = mountpoint.value.path    //The path to the mount point as seen from inside the container. 
      size    = mountpoint.value.size    //Size of the underlying volume.
      slot    = mountpoint.value.slot    //A string containing the number that identifies the mount point
      key     = mountpoint.value.key     //The number that identifies the mount point (i.e. the n in mp[n]).
      storage = mountpoint.value.storage //A string containing the volume, directory, or device to be mounted into the container (at the path specified by mp). E.g. local-lvm, local-zfs, local etc.
    }
  }

  nameserver   = local.dns_name_server
  searchdomain = local.dns_search_domain

  dynamic "network" {
    for_each = local.networks

    content {
      name     = network.value.name                       //(required) - The name of the network interface as seen from inside the container (e.g. "eth0").
      bridge   = network.value.bridge                     //- The bridge to attach the network interface to (e.g. "vmbr0").
      ip       = lookup(network.value, "ip", "dhcp")      //- The IPv4 address of the network interface. Can be a static IPv4 address (in CIDR notation), "dhcp", or "manual".
      ip6      = lookup(network.value, "ip6", null)       //- The IPv6 address of the network interface. Can be a static IPv6 address (in CIDR notation), "auto", "dhcp", or "manual".
      gw       = lookup(network.value, "gw", null)        //- The IPv4 address belonging to the network interface's default gateway.
      gw6      = lookup(network.value, "gw6", null)       //- The IPv6 address of the network interface's default gateway.
      hwaddr   = lookup(network.value, "hwaddr", null)    //- A string to set a common MAC address with the I/G (Individual/Group) bit not set. Automatically determined if not set.
      firewall = lookup(network.value, "firewall", false) //- A boolean to enable the firewall on the network interface.
      mtu      = lookup(network.value, "mtu", null)       //A string to set the MTU on the network interface.
      rate     = lookup(network.value, "rate", null)      //- A number that sets rate limiting on the network interface (Mbps).
      tag      = lookup(network.value, "tag", null)       //- A number that specifies the VLAN tag of the network interface. Automatically determined if not set.
    }
  }

}
