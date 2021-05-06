terraform {
  backend "s3" {}
}

locals {
    facts       = {
      bt_customer      = ""
      bt_product       = "cfrmit"
      bt_lob           = "cfrm"
      bt_tier          = "autolab"
      bt_env           = ""
      bt_role          = "bitbucket"
      bt_infra_cluster = "ny2-aze-ntnx-11"  
      bt_infra_network = "ny2-autolab-app-ahv"
      hostgroup        = "BT CFRM IT Bitbucket Server"
      environment      = "feature_CFRMGC_737_cfrm_cloud_devops_can_you_add_this_3_lines_to_the_end_of_etc_profile_by_puppet"
      hostname         = "us01vlcfmgmt02p"    
    }
    datacenter = {
      name = "ny2"
      id   = "ny2"
  }
}

module "mglabp_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "${local.facts.hostname}" 
  alias                = "${local.facts.bt_product}.${local.facts.bt_tier}.${local.datacenter.id}.pmg1"// cfrmcloud.cfrm.auto.gb00.db01
  bt_infra_cluster     = "${local.facts.bt_infra_cluster}"
  bt_infra_network     = "${local.facts.bt_infra_network}"
  lob                  = "${local.facts.bt_lob}"
  foreman_environment  = "${local.facts.environment}"
  foreman_hostgroup    = "${local.facts.hostgroup}"
  datacenter           = "${local.datacenter.name}"
  external_facts       = local.facts
  os_version           = "rhel7"
  cpus                 = "4"
  memory         	     = "8096" 
  additional_disks  = {
    1 = "250"
  }
} 

output "mglabp_1" {
  value = {
    "fqdn"  = "${module.mglabp_1.fqdn}",
    "alias" = "${module.mglabp_1.alias}",
    "ip"    = "${module.mglabp_1.ip}",
  }
}