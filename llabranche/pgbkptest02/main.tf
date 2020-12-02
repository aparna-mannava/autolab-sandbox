terraform {
  backend "s3" {}
}
 
locals {
  product     = "CLOUD"
  environment = "master"
  datacenter  = "ny2"
  facts       = {
    "bt_tier" = "nonprod"
    "bt_env"  = "2"
    "bt_lob" = "cloud"
    "bt_role" = "Postgresql"
    "bt_pg_version" = "12"
  }
}
 
module "pm_bk_05" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vltpmbk05"
  alias                = "${local.product} -${local.facts.bt_tier}${local.facts.bt_env} ${local.facts.bt_lob} ${local.facts.bt_role} ${local.facts.bt_pg_version}-db05"
  bt_infra_network     = "ny2-autolab-db-ahv"
  bt_infra_cluster     = "ny2-aza-ntnx-05"
  os_version           = "rhel7"
  cpus                 = "4"
  memory               = "8192"
  foreman_environment  = local.environment
  foreman_hostgroup    = "BT Postgresql DB Server"
  datacenter           = local.datacenter
  lob                  = "cloud"
  external_facts       = local.facts
  additional_disks     = {
    1 = "50",
    2 = "100",
   3 = "100"
  }
}
 
module "stdby_bk_06" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vltstdby06"
  alias                = "${local.product}-${local.facts.bt_tier}${local.facts.bt_env} ${local.facts.bt_lob} ${local.facts.bt_role} ${local.facts.bt_pg_version}-db06"
  bt_infra_network     = "ny2-autolab-db-ahv"
  bt_infra_cluster     = "ny2-aza-ntnx-05"
  os_version           = "rhel7"
  cpus                 = "2"
  memory               = "4096"
  foreman_environment  = local.environment
  foreman_hostgroup    = "BT Base Server"
  datacenter           = local.datacenter
  lob                  = "cloud"
  external_facts       = local.facts
}

module "stdby_bk_07" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vltstdby07"
  alias                = "${local.product}-${local.facts.bt_tier}${local.facts.bt_env} ${local.facts.bt_lob} ${local.facts.bt_role} ${local.facts.bt_pg_version}-db07"
  bt_infra_network     = "ny2-autolab-db-ahv"
  bt_infra_cluster     = "ny2-aza-ntnx-05"
  os_version           = "rhel7"
  cpus                 = "2"
  memory               = "4096"
  foreman_environment  = local.environment
  foreman_hostgroup    = "BT Base Server"
  datacenter           = local.datacenter
  lob		       = "cloud"
  external_facts       = local.facts
}
 
output "pm_bk_05" {
  value = {
    "fqdn"  = "${module.pm_bk_05.fqdn}",
    "alias" = "${module.pm_bk_05.alias}",
    "ip"    = "${module.pm_bk_05.ip}",
  }
}
 
output "stdby_bk_06" {
  value = {
    "fqdn"  = "${module.stdby_bk_06.fqdn}",
    "alias" = "${module.stdby_bk_06.alias}",
    "ip"    = "${module.stdby_bk_06.ip}",
  }
}

output "stdby_bk_07" {
  value = {
    "fqdn"  = "${module.stdby_bk_07.fqdn}",
    "alias" = "${module.stdby_bk_07.alias}",
    "ip"    = "${module.stdby_bk_06.ip}",
  }
}
