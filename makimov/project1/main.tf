terraform {
  backend "s3" {}
}
#  Build test server
locals {
    
    environment = "master"

    datacenter = {
        name = "ny2"
        id   = "ny2"
    }  

    facts       = {
        bt_customer         = "cfrmcloud"
        bt_product          = "cfrmcloud"
        bt_lob              = "cfrm"
        bt_tier             = "dev"
        bt_env              = "00"
        bt_role             = "cfrm"
        bt_infra_cluster    = "ny2-aze-ntnx-11"
        bt_infra_network    = "ny2-autolab-app-ahv"
        hostgroup           = "BT CFRM CLOUD Application Standalone"  
        environment         = "master"
        hostname            = "us01vlcfrm050"
    }

}
 
module "cfrm001" {
  source              = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname            = local.facts.hostname
  alias               = "${local.facts.bt_product}-${local.datacenter.id}-${local.facts.bt_tier}-${local.facts.bt_env}" #cfrmcloud-ny2-dev-00
  bt_infra_cluster    = local.facts.bt_infra_cluster
  bt_infra_network    = local.facts.bt_infra_network
  os_version          = "rhel7"
  cpus                = "2"
  memory              = "4096"
  lob                 = "CFRM"
  external_facts      = local.facts
  foreman_environment = local.facts.environment
  foreman_hostgroup   = local.facts.hostgroup
  datacenter          = local.datacenter.name
  additional_disks    = {
    1 = "24", // disk1 100gb
  }
}
 
output "cfrm001" {
  value = {
    "fqdn"  = module.cfrm001.fqdn,
    "alias" = module.cfrm001.alias,
    "ip"    = module.cfrm001.ip,
  }
}