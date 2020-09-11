terraform {
  backend "http" {}
}

locals {
  product     = "pbscap"
  environment = "master"
  datacenter  = "ny2"
}

module "pbscap_db_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlpbspg01"
  bt_infra_cluster     = "ny2-azd-ntnx-10"
  bt_infra_network     = "ny2-autolab-app-ahv"
  os_version           = "rhel7"
  cpus                 = 2
  memory               = 4096
  lob                  = "CLOUD"
  foreman_environment  = local.environment
  foreman_hostgroup    = "BT PBSCAP PG"
  datacenter           = local.datacenter
  external_facts       = {
    "bt_product" = "pbscap"
    "bt_tier"    = "pr"
  }
  additional_disks     = {
    1 = "100",
    2 = "100",
    3 = "100",
  }
}

output "pbscap_db_1" {
  value = {
    "fqdn"  = "${module.pbscap_db_1.fqdn}",
    "alias" = "${module.pbscap_db_1.alias}",
    "ip"    = "${module.pbscap_db_1.ip}",
  }
}

module "pbscap_db_2" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlpbspg02"
  bt_infra_cluster     = "ny2-azd-ntnx-10"
  bt_infra_network     = "ny2-autolab-app-ahv"
  os_version           = "rhel7"
  cpus                 = 2
  memory               = 4096
  lob                  = "CLOUD"
  foreman_environment  = local.environment
  foreman_hostgroup    = "BT PBSCAP PG"
  datacenter           = local.datacenter
  external_facts       = {
    "bt_product" = "pbscap"
    "bt_tier"    = "dr"
  }
  additional_disks     = {
    1 = "100",
    2 = "100",
    3 = "100",
  }
}

output "pbscap_db_2" {
  value = {
    "fqdn"  = "${module.pbscap_db_2.fqdn}",
    "alias" = "${module.pbscap_db_2.alias}",
    "ip"    = "${module.pbscap_db_2.ip}",
  }
}
