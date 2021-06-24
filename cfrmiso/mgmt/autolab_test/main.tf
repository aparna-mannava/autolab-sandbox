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
      hostgroup        = "BT CFRM CLOUD MGMT Base"
      environment      = "feature_CFRMCLOUD_824_cfrm_cloud_user_key"
      hostname         = "us01vlcfmgmt04c"       
    }
    datacenter = {
      name = "ny2"
      id   = "ny2"
  }
}

module "mglatst_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "${local.facts.hostname}" 
  alias                = "${local.facts.bt_product}.${local.facts.bt_tier}.${local.datacenter.id}.rmg4"// cfrmcloud.cfrm.auto.gb00.db01
  bt_infra_cluster     = "${local.facts.bt_infra_cluster}"
  bt_infra_network     = "${local.facts.bt_infra_network}"
  lob                  = "${local.facts.bt_lob}"
  foreman_environment  = "${local.facts.environment}"
  foreman_hostgroup    = "${local.facts.hostgroup}"
  datacenter           = "${local.datacenter.name}"
  external_facts       = local.facts
  os_version           = "rhel7"
  cpus                 = "2"
  memory         	     = "4096" 
  additional_disks  = {
    1 = "150"
  }
} 

output "mglatst_1" {
  value = {
    "fqdn"  = "${module.mglatst_1.fqdn}",
    "alias" = "${module.mglatst_1.alias}",
    "ip"    = "${module.mglatst_1.ip}",
  }
}