terraform {
  backend "s3" {}
}
#  Build test server
locals {

    facts       = {
        bt_product          = "cfrmcloud"
        bt_customer         = "cfrmcloud"
        bt_role             = "standalone"
        bt_tier             = "dev"
        bt_lob              = "CFRM"
        bt_ic_version       = "660_SP1" //syntax:  <major_version_number>_<servicepack>
        bt_env              = "standalone"
        bt_es_version       = "7.8.0" // should be changed according to $bt_ic_version value
        bt_artemis_version  = "2.16.0" // should be changed according to $bt_ic_version value
        bt_apacheds_version = "2.0.0_M26"
        db_host             = "us01vlcfdblab01.auto.saas-n.com" // CFRM CLOUD team central DBs, 
                                                        //can be taken from Confluence: https://confluence.bottomline.tech/display/CFRMGBSC/CFRM+Cloud+%5BOracle+DB%5D+Servers
        db_sid              = "CFRMAU01"                        
        db_port             = "1560" 
        bt_infra_cluster    = "ny2-aze-ntnx-12"
        bt_infra_network    = "ny2-autolab-app-ahv"
    }

    hostname              = "us01vlcfrm051"

    hostgroup             = "BT CFRM CLOUD Application Standalone" //relevant datacenter Foreman Host Group
    environment           = "feature_CFRMCLOUD_1439" // Puppet "controlrepo" code branch name

    datacenter = {
        name = "ny2"
        id   = "ny2"
    }

}
 
module "cfrm002" {
  source              = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname            = local.hostname
  alias               = "${local.facts.bt_product}-${local.datacenter.id}-${local.facts.bt_tier}-${local.facts.bt_env}" # cfrmcloud-ny2-dev-00
  bt_infra_cluster    = local.facts.bt_infra_cluster
  bt_infra_network    = local.facts.bt_infra_network
  os_version          = "rhel7"
  cpus                = "4"
  memory              = "8192"
  lob                 = local.facts.bt_lob
  external_facts      = local.facts
  foreman_environment = local.environment
  foreman_hostgroup   = local.hostgroup
  datacenter          = local.datacenter.name
  additional_disks    = {
    1 = "100", // disk1 100gb
  }
}
 
output "cfrm002" {
  value = {
    "fqdn"  = module.cfrm002.fqdn,
    "alias" = module.cfrm002.alias,
    "ip"    = module.cfrm002.ip,
  }
}