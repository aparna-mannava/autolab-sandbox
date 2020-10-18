terraform {
  backend "http" {}
}

locals {
    facts       = {
      "bt_customer" = "cfrmrd"
      "bt_product" = "cfrmrd"
      "bt_tier" = "dev"
      "bt_role" = "standalone"
    }
    es01facts    = {
      "bt_role" = "${local.facts.bt_role}"
      "bt_customer" = "${local.facts.bt_customer}"
      "bt_product" = "${local.facts.bt_product}"
      "bt_tier" = "${local.facts.bt_tier}"
      "bt_env" = "qa"
     }
    es02facts    = {
      "bt_role" = "${local.facts.bt_role}"
      "bt_customer" = "${local.facts.bt_customer}"
      "bt_product" = "${local.facts.bt_product}"
      "bt_tier" = "${local.facts.bt_tier}"
      "bt_env" = "qa2"
      "bt_ic_mode" = "MASTER"
     }
} 

module "elasticsearch_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlcfrmrd500"
  alias                = "cfrmrd-autolab-qa1"
  bt_infra_cluster     = "ny2-aza-ntnx-07"
  bt_infra_network     = "ny2-autolab-app-ahv"
  os_version           = "rhel7"
  external_facts       = local.es01facts
  lob                  = "CFRM"
  foreman_environment  = "feature_CFRMX_2451_artemis_elasticsearch_standalone"
  foreman_hostgroup    = "CFRMRD ElasticSearch And Artemis Standalone"
  datacenter           = "ny2"
  cpus                 = "2"
  memory         	   = "4096"
  additional_disks     = {
    1 = "50", // Disk 1
    2 = "100" //Disk 2
  }
} 

module "elasticsearch_2" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlcfrmrd501"
  alias                = "cfrmrd-autolab-qa2"
  bt_infra_cluster     = "ny2-aza-ntnx-07"
  bt_infra_network     = "ny2-autolab-app-ahv"
  os_version           = "rhel7"
  external_facts       = local.es02facts
  lob                  = "CFRM"
  foreman_environment  = "feature_CFRMX_2451_artemis_elasticsearch_standalone"
  foreman_hostgroup    = "CFRMRD ElasticSearch And Artemis Standalone"
  datacenter           = "ny2"
  cpus                 = "2"
  memory         	   = "4096"
  additional_disks     = {
    1 = "50",
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
 
output "elasticsearch_2" {
  value = {
    "fqdn"  = "${module.elasticsearch_2.fqdn}",
    "alias" = "${module.elasticsearch_2.alias}",
    "ip"    = "${module.elasticsearch_2.ip}",
  }
}    