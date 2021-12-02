locals {

  proxmox_node          = var.proxmox_node
  proxmox_resource_pool = var.proxmox_resource_pool

  os_template = var.os_template
  os_type     = var.os_type
  arch        = var.arch

  id              = var.id != null ? var.id : 0
  name            = var.name
  description     = var.description
  start_on_boot   = var.start_on_boot
  start_on_create = var.start_on_create
  unprivileged    = var.unprivileged

  password        = var.password
  public_ssh_keys = var.public_ssh_keys != null ? var.public_ssh_keys : []

  cores       = var.cores
  memory      = var.memory
  swap_memory = var.swap_memory

  enable_fuse    = var.enable_fuse
  enable_nesting = var.enable_nesting
  enable_keyctl  = var.enable_keyctl
  mount_types    = join(";", var.allowed_mount_types)

  rootfs_size_gb        = var.rootfs_size_gb
  rootfs_storage_volume = var.rootfs_storage_volume

  mount_points = { for i, mount_point in var.mount_points : i => defaults(mount_point, {
    acl       = false
    backup    = false
    quota     = false
    replicate = false
    shared    = false
  }) }

  dns_name_server   = var.dns_name_server
  dns_search_domain = var.dns_search_domain

  networks = { for key, network in var.networks : key => defaults(network, {
    firewall = false
    ip       = "dhcp"
  }) }

}
