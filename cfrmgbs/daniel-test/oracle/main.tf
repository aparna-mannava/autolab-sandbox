terraform {
  backend "s3" {}
}

locals {
    facts       = {
      bt_customer      = ""
      bt_product       = "cfrmcloud"
      bt_lob           = "cfrm"
      bt_tier          = "dev"
      bt_env           = ""
      bt_cfrm_version  = "6.4_SP1" 
      bt_role          = "oradb_19c"
      bt_infra_cluster = "ny2-aze-ntnx-12"
      bt_infra_network = "ny2-autolab-app-ahv"
      #firewall_group   = "CFRMRD_PR_ES" //"CFRMRD_PR_DB"
      hostgroup        = "BT CFRM CLOUD Oracle DB Servers"
      environment      = "feature_CFRMGC_621_bp_poc_create_vm_servers_on_saas_p" // 
      hostname         = "us01vlcfoc19v1"
    }
    datacenter = {
      name = "ny2"
      id   = "ny2"
  }
    
}

module "dblab_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "${local.facts.hostname}01-de" // gb00vlbpdb01-pr.saas-p.com
  alias                = "${local.facts.bt_product}.${local.facts.bt_customer}.${local.facts.bt_tier}.${local.datacenter.id}.db02"// cfrmcloud.bp.prod.gb00.db01
  bt_infra_cluster     = "${local.facts.bt_infra_cluster}"
  bt_infra_network     = "${local.facts.bt_infra_network}"
  #firewall_group       = "${local.facts.firewall_group}" //  adding firewall group
  lob                  = "${local.facts.bt_lob}"
  foreman_environment  = "${local.facts.environment}"
  foreman_hostgroup    = "${local.facts.hostgroup}"
  datacenter           = "${local.datacenter.name}"
  external_facts       = local.facts
  os_version           = "rhel7"
  cpus                 = "8"
  memory         	   = "16000"
  additional_disks     = {
    1 = "300",
	  2 = "300",
	  3 = "300",
	  4 = "300"
  }
} 

output "dblab_1" {
  value = {
    "fqdn"  = "${module.dblab_1.fqdn}",
    "alias" = "${module.dblab_1.alias}",
    "ip"    = "${module.dblab_1.ip}",
  }
}