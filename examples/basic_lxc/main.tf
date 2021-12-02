terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = ">=2.9"
    }
  }
}

provider "proxmox" {
  # Set PM_API_URL, PM_USER, PM_PASS environment variables
  pm_tls_insecure = var.proxmox_tls_insecure
}

module "example_lxc" {
  source = "../.."

  name        = "example-lxc"
  os_template = var.os_template

  password        = var.password
  public_ssh_keys = var.public_ssh_keys

  rootfs_size_gb = 1

  memory      = 256
  swap_memory = 128
}
