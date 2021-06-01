terraform {
  backend "s3" {}
}

locals {
    facts       = {
      bt_customer      = ""
      bt_product       = "cfrmcloud"
      bt_lob           = "cfrm"
      bt_tier          = "autolab"
      bt_env           = ""
      bt_role          = "mgmt"
      bt_infra_cluster = "ny5-azc-ntnx-16"  
      bt_infra_network = "ny2-autolab-app-ahv"
      hostgroup        = "BT CFRM CLOUD MGMT Base test"
      environment      = "feature_CFRMCLOUD_824_cfrm_cloud_user_key"
      hostname         = "us01vlcfrmmg951"       
    }
    datacenter = {
      name = "ny2"
      id   = "ny2"
  }
}

module "nfstst_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = local.facts.hostname 
  alias                = "${local.facts.bt_product}.${local.facts.bt_tier}.${local.datacenter.id}.rmg3" // cfrmcloud.cfrm.auto.gb00.db01
  bt_infra_cluster     = local.facts.bt_infra_cluster
  bt_infra_network     = local.facts.bt_infra_network
  lob                  = local.facts.bt_lob
  foreman_environment  = local.facts.environment
  foreman_hostgroup    = local.facts.hostgroup
  datacenter           = local.datacenter.name
  external_facts       = local.facts
  os_version           = "rhel7"
  cpus                 = "4"
  memory         	     = "8096" 
  additional_disks  = {
    1 = "250"
  }
} 

output "nfstst_1" {
  value = {
    "fqdn"  = module.nfstst_1.fqdn,
    "alias" = module.nfstst_1.alias,
    "ip"    = module.nfstst_1.ip,
  }
}