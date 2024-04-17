variable "node_name" {
  type        = string
  description = "Node to deploy services to"
  default     = "pve"
}

variable "hostname" {
  type        = string
  description = "Hostname to set within the vm"
  default     = "pihole"
}

variable "vm_description" {
  type        = string
  description = "Description for the vm"
  default     = "Git service"
}

variable "vm_id" {
  type        = number
  description = "VM id to register"
  default     = 9001
}

variable "vm_cpu_cores" {
  type        = number
  description = "Amount of cores to use"
  default     = 1
}

variable "vm_memory" {
  type        = number
  description = "Amount of dedicated memory to allocatee"
  default     = 1024
}

variable "vm_dns" {
  description = "DNS config for VM"
  type = object({
    domain  = string
    servers = list(string)
  })
}

variable "vm_network" {
  description = "Network config for VM"
  type = object({
    bridgename  = string
    mac_address = string
  })
}

variable "vm_ip_config" {
  description = "IP config for VM"
  type = object({
    address = string
    gateway = string
  })
}

variable "vm_datastore_id" {
  type        = string
  description = "Datastore to use for drives"
  default     = "local-lvm"
}

variable "user" {
  type        = string
  description = "Default user to create and run from"
  default     = "carrot"
}

variable "user_password" {
  type        = string
  sensitive   = true
  description = "Default user password to set"
  #to generate a user_password run the following command and replace password with your password
  #> echo -n password | sha256sum | awk '{printf "%s",$1 }' | sha256sum
}

variable "user_pub_key" {
  type        = string
  sensitive   = true
  description = "Public key to use for authentication."
  #to generate a new pubkey run following command
  #> ssh-keygen -t ed25519 -C "<EMAIL>"
}

variable "service_web_password" {
  type = string
  sensitive = true
  description = "Web password to use for authentication at pihole service"
}

variable "service_dns_one" {
  type = string
  description = "DNS server to use as first instance"
  default = "8.8.8.8" #google dns 1
}

variable "service_dns_two" {
  type = string
  description = "DNS server to use as first instance"
  default = "8.8.4.4" #google dns 2
}