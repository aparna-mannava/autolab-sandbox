terraform {
  backend "http" {}
}

locals {
    facts       = {
      "bt_customer" = "cfrmrd"
      "bt_product" = "cfrmrd"
      "bt_tier" = "dev"
      "bt_env" = ""
      "bt_role" = "standalone"
      "bt_artemis_version" = "2.11.0"
      "bt_es_version" = "7.8.0"
    }
}

module "elasticsearch_100" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlcfrmrd018"
  bt_infra_cluster     = "ny2-aza-vmw-autolab"
  bt_infra_network     = "ny2-autolab-app"
  os_version           = "rhel7"
  external_facts       = local.facts
  lob                  = "CFRM"
  foreman_environment  = "feature_CFRMX_2451_artemis_elasticsearch_standalone"
  foreman_hostgroup    = "CFRMRD ElasticSearch And Artemis Server"
  datacenter           = "ny2"
  cpus                 = "2"
  memory         	   = "4096"
  additional_disks     = {
    1 = "50",
    2 = "100"
  }
} 

output "elasticsearch_100" {
  value = {
    "fqdn"  = "${module.elasticsearch_100.fqdn}",
    "alias" = "${module.elasticsearch_100.alias}",
    "ip"    = "${module.elasticsearch_100.ip}",
  }
}