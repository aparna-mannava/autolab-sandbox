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
      "bt_env" = "autolab"
     }
    es02facts    = {
      "bt_customer" = "${local.facts.bt_customer}"
      "bt_product" = "${local.facts.bt_product}"
      "bt_tier" = "${local.facts.bt_tier}"
      "bt_role" = "${local.facts.bt_role}"
      "bt_env" = "autolab"
     }
     
    es03facts    = {
      "bt_customer" = "${local.facts.bt_customer}"
      "bt_product" = "${local.facts.bt_product}"
      "bt_tier" = "${local.facts.bt_tier}"
      "bt_role" = "${local.facts.bt_role}"
      "bt_env" = "autolab"
     }
} 

module "elasticsearch_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlcfrmrdes1"
  alias                = "cfrmrd-autolab-es1"
  bt_infra_cluster     = "ny2-aza-ntnx-13"
  bt_infra_network     = "ny2-autolab-app-ahv"
  os_version           = "rhel7"
  external_facts       = local.es01facts
  lob                  = "CFRM"
  foreman_environment  = "feature_CFRMX_3463_nginx"
  foreman_hostgroup    = "CFRMRD ElasticSearch And Artemis Cluster"
  datacenter           = "ny2"
  cpus                 = "2"
  memory         	   = "4096"
  additional_disks     = {
    1 = "100",
    2 = "100"
  }
} 

module "elasticsearch_2" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlcfrmrdes2"
  alias                = "cfrmrd-autolab-es2"
  bt_infra_cluster     = "ny2-aza-ntnx-13"
  bt_infra_network     = "ny2-autolab-app-ahv"
  os_version           = "rhel7"
  external_facts       = local.es02facts
  lob                  = "CFRM"
  foreman_environment  = "feature_CFRMX_3463_nginx"
  foreman_hostgroup    = "CFRMRD ElasticSearch And Artemis Cluster"
  datacenter           = "ny2"
  cpus                 = "2"
  memory         	   = "4096"
  additional_disks     = {
    1 = "100",
    2 = "100"
  }
}

module "elasticsearch_3" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlcfrmrdes3"
  alias                = "cfrmrd-autolab-es3"
  bt_infra_cluster     = "ny2-aza-ntnx-13"
  bt_infra_network     = "ny2-autolab-app-ahv"
  os_version           = "rhel7"
  external_facts       = local.es03facts
  lob                  = "CFRM"
  foreman_environment  = "feature_CFRMX_3463_nginx"
  foreman_hostgroup    = "CFRMRD ElasticSearch And Artemis Cluster"
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