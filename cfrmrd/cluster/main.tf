terraform {
  backend "http" {}
}

locals {
    facts       = {
      "bt_customer" = "cfrmrd"
      "bt_product" = "cfrmrd"
      "bt_tier" = "dev"
      "bt_env" = ""
      "bt_role" = "elasticsearch"
      "bt_artemis_version" = "2.11.0"
      "bt_es_version" = "7.8.0"
    }
    es01facts    = {
      "bt_server_number" = "01"
      "bt_customer" = "${local.facts.bt_customer}"
      "bt_product" = "${local.facts.bt_product}"
      "bt_tier" = "${local.facts.bt_tier}"
      "bt_env" = "${local.facts.bt_env}"
      "bt_artemis_version" = "${local.facts.bt_artemis_version}"
      "bt_es_version" = "${local.facts.bt_es_version}"
      "bt_role" = "${local.facts.bt_role}"
     }
    es02facts    = {
      "bt_customer" = "${local.facts.bt_customer}"
      "bt_product" = "${local.facts.bt_product}"
      "bt_tier" = "${local.facts.bt_tier}"
      "bt_env" = "${local.facts.bt_env}"
      "bt_artemis_version" = "${local.facts.bt_artemis_version}"
      "bt_es_version" = "${local.facts.bt_es_version}"
      "bt_role" = "${local.facts.bt_role}"
     }
    es03facts    = {
      "bt_server_number" = "03"
      "bt_customer" = "${local.facts.bt_customer}"
      "bt_product" = "${local.facts.bt_product}"
      "bt_tier" = "${local.facts.bt_tier}"
      "bt_env" = "${local.facts.bt_env}"
      "bt_artemis_version" = "${local.facts.bt_artemis_version}"
      "bt_es_version" = "${local.facts.bt_es_version}"
      "bt_role" = "${local.facts.bt_role}"
    }
}

module "elasticsearch_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlcfrmrd021"
  bt_infra_cluster     = "ny2-aza-vmw-autolab"
  bt_infra_network     = "ny2-autolab-app"
  os_version           = "rhel7"
  external_facts       = local.es01facts
  lob                  = "CFRMRD"
  foreman_environment  = "feature_CFRMX_2470_artemis_elasticsearch_cluster"
  foreman_hostgroup    = "CFRMRD ElasticSearch And Artemis Cluster"
  datacenter           = "ny2"
  cpus                 = "2"
  memory         	   = "4096"
  additional_disks     = {
    1 = "50",
    2 = "100"
  }
}

module "elasticsearch_2" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlcfrmrd022"
  bt_infra_cluster     = "ny2-aza-vmw-autolab"
  bt_infra_network     = "ny2-autolab-app"
  os_version           = "rhel7"
  external_facts       = local.es02facts
  lob                  = "CFRMRD"
  foreman_environment  = "feature_CFRMX_2470_artemis_elasticsearch_cluster"
  foreman_hostgroup    = "CFRMRD ElasticSearch And Artemis Cluster"
  datacenter           = "ny2"
  cpus                 = "2"
  memory         	   = "4096"
  additional_disks     = {
    1 = "50",
    2 = "100"
  }
}

module "elasticsearch_3" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlcfrmrd023"
  bt_infra_cluster     = "ny2-aza-vmw-autolab"
  bt_infra_network     = "ny2-autolab-app"
  os_version           = "rhel7"
  external_facts       = local.es03facts
  lob                  = "CFRMRD"
  foreman_environment  = "feature_CFRMX_2470_artemis_elasticsearch_cluster"
  foreman_hostgroup    = "CFRMRD ElasticSearch And Artemis Cluster"
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

output "elasticsearch_3" {
  value = {
    "fqdn"  = "${module.elasticsearch_3.fqdn}",
    "alias" = "${module.elasticsearch_3.alias}",
    "ip"    = "${module.elasticsearch_3.ip}",
  }
}