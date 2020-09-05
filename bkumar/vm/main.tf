#
# Building VMs for Testing
terraform {
  backend "http" {}
}
module "app_server_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlsndbxvm01"
  bt_infra_cluster     = "ny2-aze-ntnx-12"
  bt_infra_network     = "ny2-autolab-app-ahv"
  os_version           = "rhel7"
  foreman_environment  = "master"
  foreman_hostgroup    = "BT Base Server"
  datacenter           = "ny2"
  lob                  = "btiq"
  additional_disks     = {
    1 = "20"
  }
  external_facts       = {
    "bt_product"       = "btiq"
    "bt_tier"          = "dev"
  }
}

output "app_server_1" {
  value = {
    "fqdn"  = "${module.app_server_1.fqdn}",
    "alias" = "${module.app_server_1.alias}",
    "ip"    = "${module.app_server_1.ip}",
  }
}
