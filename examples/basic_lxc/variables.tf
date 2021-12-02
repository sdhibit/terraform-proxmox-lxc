variable "os_template" {
  type        = string
  description = "The volume identifier that points to the OS template."
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

variable "proxmox_tls_insecure" {
  type        = string
  description = "If true, ignore TLS errors if the HTTPS server is not trusted."
  default     = false
}
