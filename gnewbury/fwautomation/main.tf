terraform {
  backend "s3" {}
}

locals {
  image       = "rhel8"
  hostgroup   = "BT Base Server"
  environment = "master"
  datacenter  = "ny2"
  cluster     = "ny5-aza-ntnx-19"
  network     = "ny2-autolab-app-ahv"
  cpus        = "2"
  memory      = "4096"
  facts = {
    "bt_product" = "cloud"
    "bt_role"    = "test"
    "bt_tier"    = "autolab"
  }
}

module "base_server_1" {
  source              = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=feature/CLOUD-94672_firewall_automation_provider"
  hostname            = "us01vlfwats001"
  bt_infra_cluster    = local.cluster
  bt_infra_network    = local.network
  os_version          = local.image
  cpus                = local.cpus
  memory              = local.memory
  foreman_environment = local.environment
  foreman_hostgroup   = local.hostgroup
  datacenter          = local.datacenter
  external_facts      = local.facts
  lob                 = "CLOUD"
}

output "base_server_1" {
  value = {
    "fqdn"  = module.base_server_1.fqdn,
    "alias" = module.base_server_1.alias,
    "ip"    = module.base_server_1.ip,
  }
}
