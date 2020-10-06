terraform {
  backend "http" {}
}

locals {
  product     = "dgb"
  environment = "feature_CLOUD_73640"
  datacenter  = "ny2"
  facts       = {
    "bt_tier" = "ppd"
    "bt_env"  = "1"
    "bt_customer" = "fi1889"
  }
}

module "oradb_server_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vltdgb98"
  bt_infra_cluster     = "ny2-aza-ntnx-07"
  bt_infra_network     = "ny2-autolab-db-ahv"
  os_version           = "rhel7"
  cpus                 = "2"
  memory               = "4096"
  lob                  = "CLOUD"
  foreman_environment  = local.environment
  foreman_hostgroup    = "BT DGB Oradb Secondary Server"
  datacenter           = local.datacenter
  external_facts       = local.facts
  additional_disks     = {
    1 = "200",
    2 = "50",
    3 = "50"
  }
}

output "oradb_server_1" {
  value = {
    "fqdn"  = "${module.oradb_server_1.fqdn}",
    "ip"    = "${module.oradb_server_1.ip}",
  }
}

module "oradb_server_2" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vltdgb97"
  bt_infra_cluster     = "ny2-aza-ntnx-07"
  bt_infra_network     = "ny2-autolab-db-ahv"
  os_version           = "rhel7"
  cpus                 = "2"
  memory               = "4096"
  lob                  = "CLOUD"
  foreman_environment  = local.environment
  foreman_hostgroup    = "BT DGB Oradb Server"
  datacenter           = local.datacenter
  external_facts       = local.facts
  additional_disks     = {
    1 = "200",
    2 = "50",
    3 = "50"
  }
}

output "oradb_server_2" {
  value = {
    "fqdn"  = "${module.oradb_server_2.fqdn}",
    "ip"    = "${module.oradb_server_2.ip}",
  }
}

module "oradb_server_3" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vltdgb99"
  bt_infra_cluster     = "ny2-aza-ntnx-07"
  bt_infra_network     = "ny2-autolab-db-ahv"
  os_version           = "rhel7"
  cpus                 = "2"
  memory               = "4096"
  lob                  = "CLOUD"
  foreman_environment  = local.environment
  foreman_hostgroup    = "BT DGB Oradb fsfo Observer"
  datacenter           = local.datacenter
  external_facts       = local.facts
  additional_disks     = {
    1 = "200"
  }
}

output "oradb_server_3" {
  value = {
    "fqdn"  = "${module.oradb_server_3.fqdn}",
    "ip"    = "${module.oradb_server_3.ip}",
  }
}
