# Terraform Proxmox Pihole

This small terraform module sets up a minimalistic vm with pihole in it. 

## Cloud Init Configuration Options

`node_name`: name of node to deploy to (defaults to "pve")
`hostname`: hostame of vm (defaults to "pihole")
`vm_description`: description for vm (defaults to "pihole service")
`vm_id`: id of vm to register in proxmox (defaults to "9001")
`vm_cpu_cores`: number of cpu cores to allocate (defaults to 1)
`vm_memory`: amount of ram to allocate (defaults to 1024)
`vm_dns`: system dns to resolve domain request (*required* - no default)
`vm_network`: system network configuration (*required* - no default)
`vm_ip_config`: system ip configuration for networking (*required* - no default)
`vm_datastore_id`: datastore to use in proxmox (defaults to "local-lvm")
`user`: user to create in cloud init environment (defaults to: "carrot" (other word for root))
`user_password`: user password to set (*required* - no default)
`user_pub_key`: user public key to authenticate with (*required* - no default - see variables for help)


## Service Configuration Options

`service_web_password`: password to authenticate on pihole web ui
`service_dns_one`: first dns server to configure in pihole (defaults to "8.8.8.8")
`service_dns_two`: second dns server to configure in pihole (defaults to "8.8.4.4")



## Setup 
To use this module follow these steps.
First lets create a provider within your main.tf that holds the connection information towards your proxmox environment.

```yaml
provider "proxmox" {
  alias    = "lab_env"
  endpoint = var.lab_env.endpoint
  insecure = var.lab_env.insecure

  api_token = var.lab_env_auth.api_token
  ssh {
    agent    = true
    username = var.lab_env_auth.username
  }

  tmp_dir = "/var/tmp"
}
```

After this you need to pass the provider to this module via `providers`. 
It is also required to configure some additional fields that do not provide a default configuration.
A general overview of all variables is available within the [variables.tf](https://github.com/deB4SH/terraform-proxmox-cloud-init-pihole/blob/0.1/variables.tf)

```yaml
module "vm-pihole" {
  providers = {
    proxmox = proxmox.lab_env
  }
  source = "github.com/deB4SH/terraform-proxmox-cloud-init-pihole?ref=0.1"

  user = var.vm_user
  user_password = var.vm_password
  user_pub_key = var.host_pub-key

  #os dns to get new packages and more.
  vm_dns = {
    domain = "."
    servers = ["8.8.8.8","8.8.4.4"]
  }

  vm_network = {
    bridgename = "vmbr0"
    mac_address = "BC:24:11:2E:C0:03"
  }
  
  vm_ip_config = {
    address = "YOUR_DESIRED_IP_HERE/24"
    gateway = "YOUR_GATEWAY_HERE"
  }

  service_web_password = "password123456!"
  #defaults to google dns1
  #service_dns_one = "8.8.8.8"
  #defaults to google dns2
  #service_dns_two = "8.8.4.4"
}
```

