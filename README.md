# terraform-proxmox-lxc
Terraform module that creates a lxc container in Proxmox.

### Build lxc/lxd images
```bash
sudo apt update
sudo apt install snapd
sudo snap install core
sudo snap install lxd

sudo lxd init
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | ~>1.0 |
| proxmox | ~>2.9.3 |

## Providers

| Name | Version |
|------|---------|
| proxmox | ~>2.9.3 |

## Modules

No Modules.

## Resources

| Name |
|------|
| [proxmox_lxc](https://registry.terraform.io/providers/telmate/proxmox/~>2.9.3/docs/resources/lxc) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| allowed\_mount\_types | Defines the filesystem types that are allowed to be mounted. Options include 'nfs' and 'smb'. | `list(string)` | `[]` | no |
| arch | Sets the container OS architecture type. | `string` | `null` | no |
| cores | How many CPU cores to give the container. | `number` | `1` | no |
| description | The container description. | `string` | `null` | no |
| dns\_name\_server | The DNS server IP address used by the container. Will default to the Proxmox host settings if null. | `string` | `null` | no |
| dns\_search\_domain | The DNS search domain for the container. Will default to the Proxmox host settings if null. | `string` | `null` | no |
| enable\_fuse | Enable FUSE mounts in the container. | `bool` | `false` | no |
| enable\_keyctl | Enable the keyctl system call. Useful for docker. | `bool` | `false` | no |
| enable\_nesting | Allow nested virtualization. Required for docker. | `bool` | `false` | no |
| id | The Proxmox VMID of the container. If not set, the next available ID will be used. | `number` | `null` | no |
| memory | How much memory, in megabytes, to give the container. | `number` | `1024` | no |
| mount\_points | A list of objects for defining a volume to use as a container mount point. | `list(any)` | `null` | no |
| name | The container name. | `string` | n/a | yes |
| networks | A list of objects defining network interfaces for the container. | `list(any)` | <pre>[<br>  {<br>    "bridge": "vmbr0",<br>    "ip": "dhcp",<br>    "name": "eth0"<br>  }<br>]</pre> | no |
| os\_template | The volume identifier that points to the OS template or backup file. | `string` | n/a | yes |
| os\_type | The operating system type, used by LXC to setup and configure the container. Automatically determined if not set. | `string` | `null` | no |
| password | The password for the root user in the container. | `string` | `null` | no |
| proxmox\_node | Which node in the Proxmox cluster to start the container during creation. | `string` | `"proxmox"` | no |
| proxmox\_resource\_pool | Name of resource pool to create the container. | `string` | `null` | no |
| public\_ssh\_keys | The public keys of the local administrator. | `list(string)` | `[]` | no |
| rootfs\_size\_gb | Size of the root container volume in gigabytes. | `number` | `8` | no |
| rootfs\_storage\_volume | The Proxmox volume name to store the container rootfs. | `string` | `"local-lvm"` | no |
| start\_on\_boot | Specifies whether the container will be started during system bootup. | `bool` | `false` | no |
| start\_on\_create | Specifies whether the container will be started during after creation. | `bool` | `true` | no |
| swap\_memory | How much memory, in megabytes, to give to swap in the container. | `number` | `512` | no |
| unprivileged | Run the container with an unprivileged user. | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The Proxmox VMID. |
| name | The lxc host name. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
