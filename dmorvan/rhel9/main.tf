terraform {
  backend "s3" {}
}
locals {
  product          = "inf"
  environment      = "master"
  datacenter       = "ny2"
  hostname         = "us01vldmts"
  alias            = "dm-rhel9-lab"
  hostgroup        = "BT Base Server"
  lob              = "CLOUD"
  bt_infra_cluster = "ny5-azc-ntnx-16"
  bt_infra_network = "ny2-autolab-app-ahv"
  memory           = 2048
  cpus             = 2
  os_version       = "rhel9"
  facts            = {
    "bt_product"   = "inf"
    "bt_tier"      = "autolab"
  }
}

module "rhel9test1" {
  source               = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  hostname             = "${local.hostname}001"
  alias                = "${local.alias}-001"
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
module "rhel9test2" {
  source               = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  hostname             = "${local.hostname}002"
  alias                = "${local.alias}-002"
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
output "rhel9test1" {
  value = {
    "fqdn"  = module.rhel9test1.fqdn,
    "alias" = module.rhel9test1.alias,
    "ip"    = module.rhel9test1.ip,
  }
}
output "rhel9test2" {
  value = {
    "fqdn"  = module.rhel9test2.fqdn,
    "alias" = module.rhel9test2.alias,
    "ip"    = module.rhel9test2.ip,
  }
}