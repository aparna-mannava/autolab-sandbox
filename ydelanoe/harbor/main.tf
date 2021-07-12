terraform {
  backend "s3" {}
}
#
locals {
  domain          = "auto.saas-n.com"
  os_version      = "rhel8"
  lob             = "fmcloud"
  environment     = "feature_FMDO_2654_ReplicationIssue"
  cluster         = "ny2-aze-ntnx-12"
  network         = "ny2-autolab-app-ahv"
  hostgroup       = "BT FMCLOUD Harbor"
  facts           = {
    "bt_role"                 = "harbor"
    "bt_env"                  = "1"
    "bt_tier"                 = "autolab"
    "bt_product"              = "fmcloud"
  }
}

module "hbr_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlfmhbr01"
  alias                = "fm-${local.facts.bt_tier}-${local.facts.bt_role}-${local.facts.bt_env}"
  bt_infra_cluster     = local.cluster
  bt_infra_network     = local.network
  lob                  = local.lob
  foreman_hostgroup    = local.hostgroup
  foreman_environment  = local.environment
  os_version           = local.os_version
  cpus                 = "1"
  memory               = "4096"
  external_facts       = local.facts
  datacenter           = "ny2"
  additional_disks     = {
    1 = "100",
  }
}

output "hbr_1" {
  value = {
    "fqdn"  = module.hbr_1.fqdn,
    "alias" = module.hbr_1.alias,
    "ip"    = module.hbr_1.ip,
  }
}
