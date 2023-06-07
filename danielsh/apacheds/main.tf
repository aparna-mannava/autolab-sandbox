terraform {
  backend "s3" {}
}
 
locals {
 
  host_number    = "01"
  facts       = {
      bt_product          = "cfrmcloud"
      bt_role             = "apacheds"
      bt_customer         = "ny2"
      bt_tier             = "dev"
      bt_lob              = "CFRM"
      bt_env              = "01"
      //firewall_group  = "GB03-SAASN-DEV2"
      bt_apacheds_version = "2.0.0_M24"
      bt_apacheds_install = "true"
    }
    hostname              = "us01vlcfrm${local.host_number}" //us01vlcfrm01.saas-n.com
    hostgroup             = "BT CFRM CLOUD Apacheds Standalone Servers"
    environment           = "master"
   
    datacenter = {
      name = "ny2"
      id   = "ny2"
  }
 
}
 
module "cfrm_ny2_dev_01" {
  source              = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  hostname            = local.hostname
  alias               = "cfrmcloud-${local.datacenter.id}-${local.facts.bt_tier}-${local.facts.bt_customer}-${local.facts.bt_env}-${local.host_number}"//
  bt_infra_network    = "ny2-autolab-app-ahv"
  bt_infra_cluster    = "ny2-aze-ntnx-12"
  os_version          = "rhel7"
  //firewall_group      = local.facts.firewall_group//
  cpus                = "8"
  memory              = "4096"
  lob                 = "CFRM"
  external_facts      = local.facts
  foreman_environment = local.environment
  foreman_hostgroup   = local.hostgroup
  datacenter          = local.datacenter.name
  additional_disks    = {
    1 = "50", // disk1 100gb
  }
}
 
output "cfrm_ny2_dev_01" {
  value = {
    "fqdn"  = module.cfrm_ny2_dev_01.fqdn,
    "alias" = module.cfrm_ny2_dev_01.alias,
    "ip"    = module.cfrm_ny2_dev_01.ip,
  }
}