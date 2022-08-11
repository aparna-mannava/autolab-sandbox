terraform {
  backend "s3" {}
}

locals {
  product          = "inf"
  environment      = "master"
  datacenter       = "ny2"
  hostname         = "us01vllaetest1"
  hostgroup        = "BT Base Server"
  lob              = "CEA"
  bt_infra_cluster = "ny5-azc-ntnx-16"
  bt_infra_network = "ny2-autolab-app-ahv"
  memory           = 2048
  cpus             = 2
  os_version       = "rhel8"
  facts            = {
    "bt_product"   = "inf"
    "bt_tier"      = "autolab"
  }
}

module "laetest1" {
  source               = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vllaetest1"
  bt_infra_cluster     = "${local.bt_infra_cluster}"
  bt_infra_network     = "${local.bt_infra_network}"
  cpus                 = "${local.cpus}"
  lob                  = "${local.lob}"
  memory               = "${local.memory}"
  os_version           = "${local.os_version}"
  foreman_environment  = "${local.environment}"
  external_facts       = "${local.facts}"
  foreman_hostgroup    = "${local.hostgroup}"
  datacenter           = "${local.datacenter}"
}

output "laetest1" {
  value = {
    "fqdn"  = module.laetest1.fqdn,
    "ip"    = module.laetest1.ip,
  }
}
