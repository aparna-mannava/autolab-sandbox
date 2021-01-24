terraform {
  backend "http" {}
}
#  Build test server
locals {
  product     = "cfrmit"
  environment = "master" 
  hostname    = "us01"
  facts = {
    "bt_product"     = "cfrmiso"
    "bt_role"     = "mgmt"
    "bt_host_number" = "001"
  }
  datacenter = {
    name = "ny2"
    id   = "ny2"
  }

  #|## Demo server module configuration ########|#
  demo2 = { 
    hostname    = "${local.hostname}vldemo2${local.facts.bt_host_number}"
    alias       = "${local.hostname}vldemo2bucket${local.facts.bt_host_number}"
    silo        = "autolab"
    hostgroup   = "BT CFRM Demo Servers" 
    facts       = {
      "bt_product"  = "${local.facts.bt_product}"
      "bt_role"     = "${local.facts.bt_role}"}
  }
}
module "demo2" {
  source              = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname            = "${local.demo2.hostname}"
  alias               = "${local.demo2.alias}"
  ## saas-p NY2 on IL02 subnet
  #bt_infra_cluster    = "il02-aza-ntnx-01"
  #bt_infra_network    = "il02_hosted_corp_app"
  ## auto.saas-n
  bt_infra_cluster    = "ny5-aza-ntnx-14"
  bt_infra_network    = "ny2-autolab-app-ahv"
  os_version          = "rhel7"
  cpus                = "4"
  memory              = "8096"
  lob                 = "CFRM"
  external_facts      = "${local.demo2.facts}"
  foreman_environment = "${local.environment}"
  foreman_hostgroup   = "${local.demo2.hostgroup}"
  datacenter          = "${local.datacenter.name}"
  additional_disks    = {
    1 = "100", // disk1 100gb 
  }
}

output "demo2" {
  value = {
    "fqdn"  = "${module.demo2.fqdn}",
    "alias" = "${module.demo2.alias}",
    "ip"    = "${module.demo2.ip}"
  }
}