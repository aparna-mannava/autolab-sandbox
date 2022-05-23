terraform {
  backend "s3" {}
}
 
locals {
  product     = "dodyachenko"
  environment = "master"
  datacenter  = "ny2"
  facts       = {
    "bt_tier" = "dev"
    "bt_env"  = "1"
  }
}
 
module "app_server_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vltferin03"
  alias                = "${local.product} -${local.facts.bt_tier}${local.facts.bt_env}-app01"
  bt_infra_network     = "ny2-autolab-app-ahv"
  bt_infra_cluster     = "ny2-aze-ntnx-12"
  os_version           = "rhel7"
  cpus                 = "4"
  memory               = "8192"
  foreman_environment  = local.environment
  foreman_hostgroup    = "BT Base Server"
  datacenter           = local.datacenter
  external_facts       = local.facts
  additional_disks     = {
    1 = "50",
    2 = "100"
  }
}
 
module "web_server_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vltferin04"
  alias                = "${local.product}-${local.facts.bt_tier}${local.facts.bt_env}-web01"
  bt_infra_network     = "ny2-autolab-app-ahv"
  bt_infra_cluster     = "ny2-aze-ntnx-12"
  os_version           = "rhel7"
  cpus                 = "2"
  memory               = "4096"
  foreman_environment  = local.environment
  foreman_hostgroup    = "BT Base Server"
  datacenter           = local.datacenter
  external_facts       = local.facts
}
 
output "app_server_1" {
  value = {
    "fqdn"  = "${module.app_server_1.fqdn}",
    "alias" = "${module.app_server_1.alias}",
    "ip"    = "${module.app_server_1.ip}",
  }
}
 
output "web_server_1" {
  value = {
    "fqdn"  = "${module.web_server_1.fqdn}",
    "alias" = "${module.web_server_1.alias}",
    "ip"    = "${module.web_server_1.ip}",
  }
}