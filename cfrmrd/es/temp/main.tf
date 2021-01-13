terraform {
  backend "http" {}
}

locals {
    facts       = {
      "bt_customer" = "cfrmrd"
      "bt_product"  = "cfrmrd"
      "bt_tier"     = "dev"
      "bt_role"     = "elasticsearch"
    }
    es01facts    = {
      "bt_customer" = "${local.facts.bt_customer}"
      "bt_product" = "${local.facts.bt_product}"
      "bt_tier" = "${local.facts.bt_tier}"
      "bt_role" = "${local.facts.bt_role}"
      "bt_env" = "qa2"
     }
} 
 
module "elasticsearch_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlcfrmrdes1"
  alias                = "cfrmrd-autolab-es1"
  bt_infra_cluster     = "ny5-aza-ntnx-14"
  bt_infra_network     = "ny2-autolab-app-ahv"
  os_version           = "rhel7"
  external_facts       = local.es01facts
  lob                  = "CFRM"
  foreman_environment  = "feature_CFRMX_4396_IC_configuration_for_prod"
  foreman_hostgroup    = "CFRMRD ElasticSearch And Artemis Standalone"
  datacenter           = "ny2"
  cpus                 = "2"
  memory         	   = "4096"
  additional_disks     = {
    1 = "100",
    2 = "100"
  }
} 

output "elasticsearch_1" {
  value = {
    "fqdn"  = "${module.elasticsearch_1.fqdn}",
    "alias" = "${module.elasticsearch_1.alias}",
    "ip"    = "${module.elasticsearch_1.ip}",
  }
}
  