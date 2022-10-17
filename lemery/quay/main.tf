terraform {
  backend "s3" {}
}

locals {
  lob         = "CEA"
  product     = "cloud"
  environment = "master"
  datacenter  = "ny2"
  facts       = {
    "bt_tier" = "dev"
    "bt_env"  = ""
  }
}

module "quay_server_1" {
  lob                  = local.lob
  source               = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlquay01"
  bt_infra_network     = "ny2-autolab-app-ahv"
  bt_infra_cluster     = "ny2-aze-ntnx-12"
  os_version           = "rhel8"
  cpus                 = "4"
  memory               = "8192"
  foreman_environment  = local.environment
  foreman_hostgroup    = "BT Base Server"
  datacenter           = local.datacenter
  external_facts       = local.facts
  additional_disks     = {
    1 = "100",
  }
}

output "quay_server_1" {
  value = {
    "fqdn"  = module.quay_server_1.fqdn,
    "alias" = module.quay_server_1.alias,
    "ip"    = module.quay_server_1.ip,
  }
}
