#### Required Parameters #####

variable "name" {
  type        = string
  description = "The container name."
}

variable "os_template" {
  type        = string
  description = "The volume identifier that points to the OS template or backup file."
}

#### Optional Parameters #####

variable "proxmox_node" {
  type        = string
  description = "Which node in the Proxmox cluster to start the container during creation."
  default     = "proxmox"
}

variable "proxmox_resource_pool" {
  type        = string
  description = "Name of resource pool to create the container."
  default     = null
}

variable "os_type" {
  type        = string
  description = "The operating system type, used by LXC to setup and configure the container. Automatically determined if not set."
  default     = null
}

variable "arch" {
  type        = string
  description = "Sets the container OS architecture type."
  default     = null
}

variable "id" {
  type        = number
  description = "The Proxmox VMID of the container. If not set, the next available ID will be used."
  default     = null
}

variable "description" {
  type        = string
  description = "The container description."
  default     = null
}

variable "start_on_boot" {
  type        = bool
  description = "Specifies whether the container will be started during system bootup."
  default     = false
}

variable "start_on_create" {
  type        = bool
  description = "Specifies whether the container will be started during after creation."
  default     = true
}

variable "unprivileged" {
  type        = bool
  description = "Run the container with an unprivileged user."
  default     = true
}

variable "password" {
  type        = string
  description = "The password for the root user in the container."
  default     = null
  sensitive   = true

  validation {
    condition     = var.password != ""
    error_message = "The password must not be empty."
  }

  validation {
    condition     = var.password != null ? length(var.password) >= 5 : true
    error_message = "The password must be at least 5 characters."
  }
}

variable "public_ssh_keys" {
  type        = list(string)
  description = "The public keys of the local administrator."
  default     = []
}

variable "cores" {
  type        = number
  description = "How many CPU cores to give the container."
  default     = 1
}

variable "memory" {
  type        = number
  description = "How much memory, in megabytes, to give the container."
  default     = 1024
}

variable "swap_memory" {
  type        = number
  description = "How much memory, in megabytes, to give to swap in the container."
  default     = 512
}

variable "enable_fuse" {
  type        = bool
  description = "Enable FUSE mounts in the container."
  default     = false
}

variable "enable_keyctl" {
  type        = bool
  description = "Enable the keyctl system call. Useful for docker."
  default     = false
}

variable "enable_nesting" {
  type        = bool
  description = "Allow nested virtualization. Required for docker."
  default     = false
}

variable "allowed_mount_types" {
  type        = list(string)
  description = "Defines the filesystem types that are allowed to be mounted. Options include 'nfs' and 'smb'."
  default     = []
}

variable "rootfs_storage_volume" {
  type        = string
  description = "The Proxmox volume name to store the container rootfs."
  default     = "local-lvm"
}

variable "rootfs_size_gb" {
  type        = number
  description = "Size of the root container volume in gigabytes."
  default     = 8
}

variable "mount_points" {
  type = list(object({
    mp        = string
    size      = string
    storage   = string
    volume    = optional(string)
    acl       = optional(bool)
    backup    = optional(bool)
    quota     = optional(bool)
    replicate = optional(bool)
    shared    = optional(bool)
  }))
  description = "A list of objects for defining a volume to use as a container mount point."
  default     = []

  validation {
    condition     = var.mount_points != null
    error_message = "The mount points must not be null."
  }

  validation {
    condition     = length(var.mount_points) <= 256
    error_message = "There must be less than 256 mount points."
  }
}

variable "dns_name_server" {
  type        = string
  description = "The DNS server IP address used by the container. Will default to the Proxmox host settings if null."
  default     = null
}

variable "dns_search_domain" {
  type        = string
  description = "The DNS search domain for the container. Will default to the Proxmox host settings if null."
  default     = null
}

variable "networks" {
  type = map(object({
    bridge   = string
    firewall = optional(bool)
    gw       = optional(string)
    gw6      = optional(string)
    hwaddr   = optional(string)
    ip       = optional(string)
    ip6      = optional(string)
    mtu      = optional(string)
    rate     = optional(number)
    tag      = optional(number)
  }))
  description = "A map of objects defining network interfaces for the container."
  default = {
    "eth0" = {
      bridge = "vmbr0"
      ip     = "dhcp"
    }
  }

  validation {
    condition     = var.networks != null
    error_message = "The network map must not be empty."
  }
}
