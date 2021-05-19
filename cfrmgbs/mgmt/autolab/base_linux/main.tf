terraform {
  backend "s3" {}
}

locals {
    facts       = {
      bt_customer      = "" //bp
      bt_product       = "cfrmcloud"
      bt_lob           = "cfrm"
      bt_tier          = "autolab"
      bt_env           = ""
      bt_role          = "mgmt"
      bt_infra_cluster = "ny2-aze-ntnx-11" // https://us-pr-stash.saas-p.com/projects/TRRFRM/repos/terraform-module-infrastructure/browse
      bt_infra_network = "ny2-autolab-app-ahv" // https://us-pr-stash.saas-p.com/projects/TRRFRM/repos/terraform-module-infrastructure/browse/data/networks
      #firewall_group   = "CFRMRD_PR_ES" //"CFRMRD_PR_DB"
      hostgroup        = "BT CFRM CLOUD MGMT Base"
      environment      = "CFRMCLOUD_966_base_nfs_client_linux_role" // 
      hostname         = "us01vlcfmg01-al" //  us01vlcfmgmt01a.auto.saas-p.com
    }
    datacenter = {
      name = "ny2"
      id   = "ny2"
  }
  
}

module "mglab_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "${local.facts.hostname}" // us01vlcfmgmt01a.auto.saas-p.com 
  alias                = "${local.facts.bt_product}.${local.facts.bt_customer}.${local.facts.bt_tier}.${local.datacenter.id}.dmg1"// cfrmcloud.cfrm.auto.gb00.db01
  bt_infra_cluster     = "${local.facts.bt_infra_cluster}"
  bt_infra_network     = "${local.facts.bt_infra_network}"
  #firewall_group       = "${local.facts.firewall_group}" // adding firewall group
  lob                  = "${local.facts.bt_lob}"
  foreman_environment  = "${local.facts.environment}"
  foreman_hostgroup    = "${local.facts.hostgroup}"
  datacenter           = "${local.datacenter.name}"
  external_facts       = local.facts
  os_version           = "rhel7"
  cpus                 = "2"
  memory         	     = "4096"
  additional_disks     = {
    1 = "50"
  }
} 

output "mglab_1" {
  value = {
    "fqdn"  = "${module.mglab_1.fqdn}",
    "alias" = "${module.mglab_1.alias}",
    "ip"    = "${module.mglab_1.ip}",
  }
}