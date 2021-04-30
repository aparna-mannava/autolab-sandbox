terraform {
  backend "s3" {}
}

locals {
    hostname    = "us01vlcfes"
    facts       = {
      bt_customer             = ""
      bt_product              = "cfrmcloud"
      bt_lob                  = "cfrm"
      bt_tier                 = "autolab" //     PROD
      bt_env                  = "01"
      bt_role                 = "elastic"
      bt_infra_cluster        = "ny2-aza-ntnx-05"
      bt_infra_network        = "ny2-autolab-app-ahv"
      hostgroup               = "CFRM BT CLOUD Elastic Servers"
      environment             = "CFRMCLOUD_920_elasticsearch_cluster_not_updating_cluster_file" //
      bt_artemis_version      = "2.11.0"
      bt_es_version           = "7.8.0"
      bt_apacheds_version     = "2.0.0_M24"
      bt_jmx_prometheus_version = "0.14.0"
      bt_artemis1_fqdn        = "${local.hostname}01-lb" //us01vlcfes01-ut.saas-p.com
      bt_artemis2_fqdn        = "${local.hostname}02-lb" //us01vlcfes01-ut.saas-p.com
      bt_artemis3_fqdn        = "${local.hostname}03-lb" //us01vlcfes01-ut.saas-p.com
    }
    datacenter = {
    name = "ny2"
    id   = "ny2"
  }
    es01facts    = {
      "bt_customer"               = "${local.facts.bt_customer}"
      "bt_product"                = "${local.facts.bt_product}"
      "bt_tier"                   = "${local.facts.bt_tier}"
      "bt_env"                    = "${local.facts.bt_env}"
      "bt_role"                   = "${local.facts.bt_role}"
      "bt_es_version"             = "${local.facts.bt_es_version}"
      "bt_artemis_version"        = "${local.facts.bt_artemis_version}"
      "bt_apacheds_version"       = "${local.facts.bt_apacheds_version}"
      "bt_jmx_prometheus_version" = "${local.facts.bt_jmx_prometheus_version}"
      "bt_artemis1_fqdn"          = "${local.facts.bt_artemis1_fqdn}"
     }
    es02facts    = {
      "bt_customer"               = "${local.facts.bt_customer}"
      "bt_product"                = "${local.facts.bt_product}"
      "bt_tier"                   = "${local.facts.bt_tier}"
      "bt_env"                    = "${local.facts.bt_env}"
      "bt_role"                   = "${local.facts.bt_role}"
      "bt_es_version"             = "${local.facts.bt_es_version}"
      "bt_artemis_version"        = "${local.facts.bt_artemis_version}"
      "bt_apacheds_version"       = "${local.facts.bt_apacheds_version}"
      "bt_jmx_prometheus_version" = "${local.facts.bt_jmx_prometheus_version}"
      "bt_artemis2_fqdn"          = "${local.facts.bt_artemis2_fqdn}"
     }
    es03facts    = {
      "bt_customer"               = "${local.facts.bt_customer}"
      "bt_product"                = "${local.facts.bt_product}"
      "bt_tier"                   = "${local.facts.bt_tier}"
      "bt_env"                    = "${local.facts.bt_env}"
      "bt_role"                   = "${local.facts.bt_role}"
      "bt_es_version"             = "${local.facts.bt_es_version}"
      "bt_artemis_version"        = "${local.facts.bt_artemis_version}"
      "bt_apacheds_version"       = "${local.facts.bt_apacheds_version}"
      "bt_jmx_prometheus_version" = "${local.facts.bt_jmx_prometheus_version}"
      "bt_artemis3_fqdn"          = "${local.facts.bt_artemis3_fqdn}"
    }
}

module "elasticsearch_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "${local.hostname}01-lb"
  alias                = "${local.facts.bt_product}-${local.facts.bt_tier}-${local.datacenter.id}-elk01"// cfrmcloud-uat-gb00-elk01
  bt_infra_cluster     = "${local.facts.bt_infra_cluster}"
  bt_infra_network     = "${local.facts.bt_infra_network}"
  lob                  = "${local.facts.bt_lob}"
  foreman_environment  = "${local.facts.environment}"
  foreman_hostgroup    = "${local.facts.hostgroup}"
  datacenter           = "${local.datacenter.name}"
  external_facts       = local.es01facts
  os_version           = "rhel7"
  cpus                 = "4"
  memory         	   = "16192"
  additional_disks     = {
    1 = "150",
    2 = "150"
  }
} 

module "elasticsearch_2" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "${local.hostname}02-lb"
  alias                = "${local.facts.bt_product}-${local.facts.bt_tier}-${local.datacenter.id}-elk02"// cfrmcloud-uat-gb00-elk02
  bt_infra_cluster     = "${local.facts.bt_infra_cluster}"
  bt_infra_network     = "${local.facts.bt_infra_network}"
  lob                  = "${local.facts.bt_lob}"
  foreman_environment  = "${local.facts.environment}"
  foreman_hostgroup    = "${local.facts.hostgroup}"
  datacenter           = "${local.datacenter.name}"
  external_facts       = local.es02facts
  os_version           = "rhel7"
  cpus                 = "4"
  memory         	   = "16192"
  additional_disks     = {
    1 = "150",
    2 = "150"
  }
}

module "elasticsearch_3" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "${local.hostname}03-lb"
  alias                = "${local.facts.bt_product}-${local.facts.bt_tier}-${local.datacenter.id}-elk03"//cfrmcloud-uat-gb00-elk03
  bt_infra_cluster     = "${local.facts.bt_infra_cluster}"
  bt_infra_network     = "${local.facts.bt_infra_network}"
  lob                  = "${local.facts.bt_lob}"
  foreman_environment  = "${local.facts.environment}"
  foreman_hostgroup    = "${local.facts.hostgroup}"
  datacenter           = "${local.datacenter.name}" 
  external_facts       = local.es03facts
  os_version           = "rhel7"
  cpus                 = "4"
  memory         	   = "16192"
  additional_disks     = {
    1 = "150",
    2 = "150"
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