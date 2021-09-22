terraform {
  backend "s3" {}
}
#  Build test server
locals {
  environment = "feature_CFRMCLOUD_1432_devops_standalone_automate_sql_script"
  datacenter = {
      name = "ny2"
      id   = "ny2"
  }

  host_number    = "02"
  hostname       = "us01vlcfrmfml${local.host_number}"
  silo           = "standalone"
  hostgroup      = "BT CFRM CLOUD Application Standalone"
  facts       = {
    bt_product    = "cfrmcloud"
    bt_role       = "cfrm"
    bt_customer   = "fml"
    bt_tier       = "autolab"
    bt_lob        = "CFRM"
    bt_ic_version = "610_SP2"
    bt_env        = "standalone"
    //firewall_group  = "GB03-SAASN-DEV2"  
    db_host       = "us01vlcfdblab01.auto.saas-n.com" 
    db_sid        = "CFRMAU01"                        
    db_port       = "1560" 
    }
}

module "cfrm_fml_02" {
  source              = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname            = local.hostname
  alias               = "cfrm-cloud-${local.facts.bt_tier}-${local.datacenter.id}-${local.facts.bt_customer}-${local.facts.bt_env}-ic-${local.host_number}"
  bt_infra_cluster    = "ny5-azc-ntnx-16"
  bt_infra_network    = "ny2-autolab-app-ahv"
  os_version          = "rhel7"
  //firewall_group      = local.facts.firewall_group
  cpus                = "8"
  memory              = "32000"
  lob                 = "CFRM"
  external_facts      = local.facts
  foreman_environment = local.environment
  foreman_hostgroup   = local.hostgroup
  datacenter          = local.datacenter.name
  additional_disks    = {
    1 = "100", // disk1 100gb
  }
}

output "cfrm_fml_02" {
  value = {
    "fqdn"  = module.cfrm_fml_02.fqdn,
    "alias" = module.cfrm_fml_02.alias,
    "ip"    = module.cfrm_fml_02.ip,
  }
}