resource "proxmox_virtual_environment_file" "cloud-init-configfile" {
  node_name    = var.node_name
  content_type = "snippets"
  datastore_id = "local"

  source_raw {
    data = templatefile("${path.module}/cloud-init/common.yaml.tftpl", {
      hostname = var.hostname
      user = var.user
      user_password = var.user_password
      user_pub_key  = var.user_pub_key
      service_web_password = var.service_web_password
      service_dns_one = var.service_dns_one
      service_dns_two = var.service_dns_two
    })
    file_name = format("%s-%s", var.hostname, "cloud-init-lab-pihole.yaml")
  }
}
