terraform {
  backend "http" {}
}
locals {
 environment = "feature_CLOUD_70904"
 datacenter  = "ny2"
 facts       = {
   "bt_tier" = "test"
   "bt_role" = "nix_bastion"
   "bt_product" = "inf"
 }
}

module "rhel7-bastion" {
 source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
 hostname             = "us01vlbhtst07"
 bt_infra_environment = "ny2-autolab-app"
 os_version           = "rhel7"
 foreman_environment  = local.environment
 foreman_hostgroup    = "BT Linux Bastion Hosts"
 datacenter           = local.datacenter
 external_facts       = local.facts
}

module "rhel8-bastion" {
 source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
 hostname             = "us01vlbhtst08"
 bt_infra_environment = "ny2-autolab-app"
 os_version           = "rhel8"
 foreman_environment  = local.environment
 foreman_hostgroup    = "BT Linux Bastion Hosts"
 datacenter           = local.datacenter
 external_facts       = local.facts
}

output "rhel8-bastion" {
 value = {
   "fqdn"  = "${module.rhel8-bastion.fqdn}",
   "ip"    = "${module.rhel8-bastion.ip}",
 }
}

output "rhel7-bastion" {
 value = {
   "fqdn"  = "${module.rhel7-bastion.fqdn}",
   "ip"    = "${module.rhel7-bastion.ip}",
 }
}
