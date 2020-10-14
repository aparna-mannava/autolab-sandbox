terraform {
  backend "http" {}
}

locals {
    facts       = {
      "bt_customer" = "cfrmrd"
      "bt_product" = "cfrmrd"
      "bt_tier" = "dev"
      "bt_role" = "elasticsearch"
    }
    es01facts    = {
      "bt_customer" = "${local.facts.bt_customer}"
      "bt_product" = "${local.facts.bt_product}"
      "bt_tier" = "${local.facts.bt_tier}"
      "bt_env" = "${local.facts.bt_env}"
      "bt_role" = "${local.facts.bt_role}"
      "bt_env" = "qa2"
     }
    es02facts    = {
      "bt_customer" = "${local.facts.bt_customer}"
      "bt_product" = "${local.facts.bt_product}"
      "bt_tier" = "${local.facts.bt_tier}"
      "bt_env" = "${local.facts.bt_env}"
      "bt_role" = "${local.facts.bt_role}"
      "bt_env" = "qa2"
     }
    es03facts    = {
      "bt_customer" = "${local.facts.bt_customer}"
      "bt_product" = "${local.facts.bt_product}"
      "bt_tier" = "${local.facts.bt_tier}"
      "bt_env" = "${local.facts.bt_env}"
      "bt_role" = "${local.facts.bt_role}"
      "bt_env" = "qa2"
    }
}

module "elasticsearch_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlcfrmrd021"
  alias                = "cfrmrd-autolab-es1-cluster"
  bt_infra_cluster     = "ny2-aza-ntnx-07"
  bt_infra_network     = "ny2-autolab-app-ahv"
  os_version           = "rhel7"
  external_facts       = local.es01facts
  lob                  = "CFRM"
  foreman_environment  = "feature_CFRMX_2470_artemis_elasticsearch_cluster"
  foreman_hostgroup    = "CFRMRD ElasticSearch And Artemis Cluster2"
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
  alias                = "cfrmrd-autolab-es2-cluster"
  bt_infra_cluster     = "ny2-aza-ntnx-07"
  bt_infra_network     = "ny2-autolab-app-ahv"
  os_version           = "rhel7"
  external_facts       = local.es02facts
  lob                  = "CFRM"
  foreman_environment  = "feature_CFRMX_2470_artemis_elasticsearch_cluster"
  foreman_hostgroup    = "CFRMRD ElasticSearch And Artemis Cluster2"
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
  alias                = "cfrmrd-autolab-es3-cluster"
  bt_infra_cluster     = "ny2-aza-ntnx-07"
  bt_infra_network     = "ny2-autolab-app-ahv"
  os_version           = "rhel7"
  external_facts       = local.es03facts
  lob                  = "CFRM"
  foreman_environment  = "feature_CFRMX_2470_artemis_elasticsearch_cluster"
  foreman_hostgroup    = "CFRMRD ElasticSearch And Artemis Cluster2"
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