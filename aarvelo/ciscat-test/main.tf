terraform {
  backend "http" {}
}

locals {
  facts       = {
    "bt_product" = "inf"
  }
}

module "ciscat_nix_server_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlcis888"
  bt_infra_cluster     = "ny2-aza-vmw-autolab"
  bt_infra_network     = "ny2-autolab-app"
  lob                  = "INF"
  cpus                 = "2"
  memory               = "4096"
  external_facts       = local.facts
  os_version           = "rhel8"
  foreman_environment  = "feature_CLOUD_67111_CIS_NIX"
  foreman_hostgroup    = "BT Base Server"
  datacenter           = "ny2"
  additional_disks     = {
    1 = "100",
  }
}

module "ciscat_win_server_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vwcis000"
  bt_infra_cluster     = "ny2-aza-vmw-autolab"
  bt_infra_network     = "ny2-autolab-app"
  lob                  = "INF"
  cpus                 = "2"
  memory               = "8192"
  external_facts       = local.facts
  os_version           = "win2016"
  foreman_environment  = "feature_CLOUD_67111_CIS_NIX"
  foreman_hostgroup    = "BT Base Windows Server"
  datacenter           = "ny2"
  additional_disks     = {
    1 = "100",
  }
}



output "ciscat_nix_server_1" {
  value = {
    "fqdn"  = "${module.ciscat_nix_server_1.fqdn}",
    "alias" = "${module.ciscat_nix_server_1.alias}",
    "ip"    = "${module.ciscat_nix_server_1.ip}",
  }
}

output "ciscat_win_server_1" {
  value = {
    "fqdn"  = "${module.ciscat_win_server_1.fqdn}",
    "alias" = "${module.ciscat_win_server_1.alias}",
    "ip"    = "${module.ciscat_win_server_1.ip}",
  }
}

