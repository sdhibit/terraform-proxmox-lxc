output "id" {
  description = "The Proxmox VMID."
  value       = proxmox_lxc.lxc.vmid
}

output "name" {
  description = "The lxc host name."
  value       = proxmox_lxc.lxc.hostname
}
