terraform {
  backend "s3" {}
}

locals {
    facts       = {
      bt_customer      = "bp" //bp
      bt_product       = "cfrmcloud"
      bt_lob           = "cfrm"
      bt_tier          = "prod" //PROD
      bt_env           = "1"
      bt_cfrm_version  = "6.1_SP1" // Need to be updated
      bt_role          = "oradb"
      bt_infra_cluster = "ny2-aze-ntnx-11"
      bt_infra_network = "ny2-autolab-app-ahv"
      #firewall_group   = " CFRMRD_PR_ES" // "CFRMRD_PR_DB"
      hostgroup        = "BT CFRM CLOUD Oracle DB Servers"
      environment      = "feature_CFRMGC_621_bp_poc_create_vm_servers_on_saas_p" // 
      hostname         = "us01vlbpdb"
    }
    datacenter = {
      name = "ny2"
      id   = "ny2"
  }
    db01prod    = {
      "bt_customer"     = "${local.facts.bt_customer}"
      "bt_product"      = "${local.facts.bt_product}"
      "bt_tier"         = "${local.facts.bt_tier}"
      "bt_env"          = "${local.facts.bt_env}"
      "bt_role"         = "${local.facts.bt_role}"
      "bt_cfrm_version" = "${local.facts.bt_cfrm_version}"
     }
}

module "dblab_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "${local.facts.hostname}01-pr" // gb00vlbpdb01-pr.saas-p.com
  alias                = "${local.facts.bt_product}.${local.facts.bt_customer}.${local.facts.bt_tier}.${local.datacenter.id}.db01"// cfrmcloud.bp.prod.gb00.db01
  bt_infra_cluster     = "${local.facts.bt_infra_cluster}"
  bt_infra_network     = "${local.facts.bt_infra_network}"
  #firewall_group       = "${local.facts.firewall_group}" //adding firewall group
  lob                  = "${local.facts.bt_lob}"
  foreman_environment  = "${local.facts.environment}"
  foreman_hostgroup    = "${local.facts.hostgroup}"
  datacenter           = "${local.datacenter.name}"
  external_facts       = local.db01prod
  os_version           = "rhel7"
  cpus                 = "4"
  memory         	   = "8096"
  additional_disks     = {
    1 = "250",
	  2 = "250",
	  3 = "250",
	  4 = "250"
  }
} 

output "dblab_1" {
  value = {
    "fqdn"  = "${module.dblab_1.fqdn}",
    "alias" = "${module.dblab_1.alias}",
    "ip"    = "${module.dblab_1.ip}",
  }
}