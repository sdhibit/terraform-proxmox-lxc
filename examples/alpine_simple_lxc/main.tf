terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "~>2.6"
    }
  }
}

provider "proxmox" {
  # Set PM_API_URL, PM_USER, PM_PASS environment variables
  pm_tls_insecure = true
}

module "example_alpine_lxc" {
  source = "../.."

  name        = "alpine-lxc-test"
  os_template = "disks:vztmpl/alpine-3.12-default_20200823_amd64.tar.xz"
}
