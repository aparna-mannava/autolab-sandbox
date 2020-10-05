terraform {
  backend "s3" {}
}

locals {
  product        = "oem"
  environment    = "nonprod"
  datacenter     = "ny2"
  hostname       = "us01vlpmsv031"
  hostgroup      = "BT OMS Primary"
  facts          = {
    "bt_tier"         = "dev"
    "bt_domain"   = "saas-n.com"
    "bt_role"  = "em_primary"
    "bt_env" = "2"
  }
}


module "winpm_server_oem01" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "${local.hostname}"
  alias                = ""
  bt_infra_cluster     = "ny2-aza-vmw-autolab"
  bt_infra_network     = "ny2-autolab-db"
  lob                  = "cloud"
  os_version           = "rhel7"
  cpus                 = "2"
  memory               = "8092"
  external_facts       = "${local.facts}"
  foreman_environment  = "${local.environment}"
  foreman_hostgroup    = "${local.hostgroup}"
  datacenter           = "${local.datacenter}"
  additional_disks     = {
    1 = "200",
    2 = "200"
  }
}

output "winpm_server_oem01" {
  value = {
    "fqdn"  = "${module.winpm_server_oem01.fqdn}",
    "alias" = "${module.winpm_server_oem01.alias}",
    "ip"    = "${module.winpm_server_oem01.ip}",
  }
}
