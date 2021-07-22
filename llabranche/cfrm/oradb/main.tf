terraform {
  backend "s3" {}
}

locals {
  environment = "master"
  datacenter  = "ny2"
  facts       = {
    "bt_tier" = "ppd"
    "bt_env"  = "2"
    "bt_lob"   = "cloud"
  }
}

module "ora_diag_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlocfm003"
  alias                = "${local.datacenter}-ora-db01"
  bt_infra_cluster     = "ny5-azc-ntnx-16"
  bt_infra_network     = "ny2-autolab-app-ahv"
  os_version           = "rhel7"
  cpus                 = "2"
  memory               = "4096"
  external_facts       = local.facts
  foreman_environment  = local.environment
  foreman_hostgroup    = "BT CFRM Oracle Server"
  lob			= "cloud"
  datacenter           = local.datacenter
  additional_disks     = {
    1 = "100",
	2 = "200",
  }
}
 
output "ora_diag_1" {
  value = {
    "fqdn"  = module.ora_diag_1.fqdn,
    "alias" = module.ora_diag_1.alias,
    "ip"    = module.ora_diag_1.ip,
  }
}
