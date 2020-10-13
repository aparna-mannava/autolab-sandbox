terraform {
  backend "http" {}
}

locals {
  facts       = {
    "bt_tier"       = "dev"
    "bt_product"    = "cagso"
    "bt_role"       = "postgresql"
    "bt_env"        = "1"
    "bt_pg_version" = "12"
  }
}

module "cagso-pg12" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlcagspg221"
  alias                = "cagso_pg_12_auto_03"
  bt_infra_cluster     = "ny2-aza-vmw-autolab"
  bt_infra_network     = "ny2-autolab-app-ahv"
  os_version           = "rhel7"
  foreman_environment  = "master"
  foreman_hostgroup    = "BT Postgresql DB Server"
  datacenter           = "ny2"
  lob                  = "cloud"
  cpus                 = "2"
  memory               = "4098"
  additional_disks     = {
    1 = "100"
    2 = "100"
    3 = "100"
  }
  external_facts       = local.facts
}

output "cagso-pg12" {
  value = {
    "fqdn"  = "${module.cagso-pg12.fqdn}",
    "alias" = "${module.cagso-pg12.alias}",
    "ip"    = "${module.cagso-pg12.ip}",
  }

}

module "cagso-pg12_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlcagspg222"
  alias                = "cagso_pg_12_auto_04"
  bt_infra_cluster     = "ny2-aza-vmw-autolab"
  bt_infra_network     = "ny2-autolab-app-ahv"
  os_version           = "rhel7"
  foreman_environment  = "master"
  foreman_hostgroup    = "BT Postgresql DB Server"
  datacenter           = "ny2"
  lob                  = "cloud"
  cpus                 = "2"
  memory               = "4098"
  additional_disks     = {
    1 = "100"
    2 = "100"
    3 = "100"
  }
  external_facts       = local.facts
}

output "cagso-pg12_1" {
  value = {
    "fqdn"  = "${module.cagso-pg12_1.fqdn}",
    "alias" = "${module.cagso-pg12_1.alias}",
    "ip"    = "${module.cagso-pg12_1.ip}",
  }

}

