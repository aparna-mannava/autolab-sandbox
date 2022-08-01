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
module "dmrhel91" {
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
module "dmrhel92" {
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
output "dmrhel91" {
  value = {
    "fqdn"  = module.dmrhel91.fqdn,
    "alias" = module.dmrhel91.alias,
    "ip"    = module.dmrhel91.ip,
  }
}
output "dmrhel92" {
  value = {
    "fqdn"  = module.dmrhel92.fqdn,
    "alias" = module.dmrhel92.alias,
    "ip"    = module.dmrhel92.ip,
  }
}