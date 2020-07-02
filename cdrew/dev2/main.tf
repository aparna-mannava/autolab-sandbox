terraform {
  backend "http" {}
}

locals {
  facts       = {
    "bt_tier" = "dev"
    "bt_env"  = "1"
    "bt_product" = "inf"
  }
}

module "db_server1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlcrdpg01"
  alias                = "bt-${local.facts.bt_tier}${local.facts.bt_env}-pg01"
  bt_infra_network     = "ny2-autolab-db"
  bt_infra_cluster     = "ny2-aza-vmw-autolab"
  cpus                 = 2
  memory               = 8096
  os_version           = "rhel7"
  external_facts       = local.facts
  lob       	       = "dev"
  foreman_environment  = "feature_CEA_7999_pg"
  foreman_hostgroup    = "BT Postgresql DB Server"
  datacenter           = "ny2"
  additional_disks     = {
    1 = "100",
    2 = "50",
  }
}

output "ss_server1" {
  value = {
    "fqdn"  = "${module.db_server1.fqdn}",
    "alias" = "${module.db_server1.alias}",
    "ip"    = "${module.db_server1.ip}",
  }
}
