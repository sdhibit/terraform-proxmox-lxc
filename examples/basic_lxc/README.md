# Proxmox LXC Basic Example
A basic LXC deployment example.

## Running

Replace PM_* ENV vars with appropriate values.
```bash
 
export PM_API_URL=https://proxmox.example.com:8006/api2/json
export PM_USER=terraform@pve
export PM_PASS=mypassword

terraform init
terraform apply
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| proxmox | >=2.9 |

## Providers

No provider.

## Modules

| Name | Source | Version |
|------|--------|---------|
| example_lxc | ../.. |  |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| os\_template | The volume identifier that points to the OS template. | `string` | n/a | yes |
| password | The password for the root user in the container. | `string` | `null` | no |
| proxmox\_tls\_insecure | If true, ignore TLS errors if the HTTPS server is not trusted. | `string` | `false` | no |
| public\_ssh\_keys | The public keys of the local administrator. | `list(string)` | `[]` | no |

## Outputs

No output.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
