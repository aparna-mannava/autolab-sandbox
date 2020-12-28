terraform {
  backend "s3" {}
}
module "orap_server_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlora2sbx01"
  bt_infra_cluster     = "ny5-aza-ntnx-14"
  bt_infra_network     = "ny2-autolab-db-ahv"
  os_version           = "rhel7"
  foreman_environment  = "master"
  foreman_hostgroup    = "BT Base Server"
  datacenter           = "ny2"
  lob                  = "cloud"
  additional_disks     = {
    1 = "100",
    2 = "50"
  }
  external_facts       = {
    "bt_tier" = "dev"
  }
}

output "orap_server_1" {
  value = {
    "fqdn"  = "${module.orap_server_1.fqdn}",
    "alias" = "${module.orap_server_1.alias}",
    "ip"    = "${module.orap_server_1.ip}",
  }
}
