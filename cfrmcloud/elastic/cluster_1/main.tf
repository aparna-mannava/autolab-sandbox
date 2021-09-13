terraform {
  backend "s3" {}
}

locals {
    hostname    = "us01vlcfel"
    facts       = {
      bt_customer             = ""
      bt_product              = "cfrmcloud"
      bt_lob                  = "CFRM"
      bt_tier                 = "autolab" // rebuild
      bt_env                  = "00"
      bt_role                 = "elastic"
      bt_infra_cluster        = "ny5-azc-ntnx-16"  
      bt_infra_network        = "ny2-autolab-app-ahv"
      hostgroup               = "CFRM BT CLOUD Elastic Servers"
      environment             = "master"   //  
      bt_artemis_version      = "2.8.0"
      bt_es_version           = "5.6.16"
      bt_apacheds_version     = "2.0.0_M24"
      bt_jmx_prometheus_version = "0.14.0"
      bt_artemis1_fqdn        = "${local.hostname}01-au" //us01vlcfel01-ut.saas-p.com
      bt_artemis2_fqdn        = "${local.hostname}02-au" //us01vlcfel02-ut.saas-p.com
      bt_artemis3_fqdn        = "${local.hostname}03-au" //us01vlcfel03-ut.saas-p.com
    }
    datacenter = {
      name = "ny2"
      id   = "ny2"
  }
    es01facts    = {
      "bt_customer"               = local.facts.bt_customer
      "bt_product"                = local.facts.bt_product
      "bt_tier"                   = local.facts.bt_tier
      "bt_env"                    = local.facts.bt_env
      "bt_role"                   = local.facts.bt_role
      "bt_es_version"             = local.facts.bt_es_version
      "bt_artemis_version"        = local.facts.bt_artemis_version
      "bt_apacheds_version"       = local.facts.bt_apacheds_version
      "bt_jmx_prometheus_version" = local.facts.bt_jmx_prometheus_version
      "bt_artemis1_fqdn"          = local.facts.bt_artemis1_fqdn
     }
    es02facts    = {
      "bt_customer"               = local.facts.bt_customer
      "bt_product"                = local.facts.bt_product
      "bt_tier"                   = local.facts.bt_tier
      "bt_env"                    = local.facts.bt_env
      "bt_role"                   = local.facts.bt_role
      "bt_es_version"             = local.facts.bt_es_version
      "bt_artemis_version"        = local.facts.bt_artemis_version
      "bt_apacheds_version"       = local.facts.bt_apacheds_version
      "bt_jmx_prometheus_version" = local.facts.bt_jmx_prometheus_version
      "bt_artemis2_fqdn"          = local.facts.bt_artemis2_fqdn
     }
    es03facts    = {
      "bt_customer"               = local.facts.bt_customer
      "bt_product"                = local.facts.bt_product
      "bt_tier"                   = local.facts.bt_tier
      "bt_env"                    = local.facts.bt_env
      "bt_role"                   = local.facts.bt_role
      "bt_es_version"             = local.facts.bt_es_version
      "bt_artemis_version"        = local.facts.bt_artemis_version
      "bt_apacheds_version"       = local.facts.bt_apacheds_version
      "bt_jmx_prometheus_version" = local.facts.bt_jmx_prometheus_version
      "bt_artemis3_fqdn"          = local.facts.bt_artemis3_fqdn
    }
}

module "elk_dev_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "${local.hostname}01-au"
  alias                = "${local.facts.bt_product}-${local.facts.bt_tier}-${local.hostname}-${local.datacenter.id}-elk01"// cfrmcloud-uat-us01vlcfel-gb00-elk01
  bt_infra_cluster     = local.facts.bt_infra_cluster
  bt_infra_network     = local.facts.bt_infra_network
  #firewall_group       = local.facts.firewall_group
  lob                  = local.facts.bt_lob
  foreman_environment  = local.facts.environment
  foreman_hostgroup    = local.facts.hostgroup
  datacenter           = local.datacenter.name
  external_facts       = local.es01facts
  os_version           = "rhel7"
  cpus                 = "4"
  memory         	   = "16192"
  additional_disks     = {
    1 = "150",
    2 = "150"
  }
} 

module "elk_dev_2" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "${local.hostname}02-au"
  alias                = "${local.facts.bt_product}-${local.facts.bt_tier}-${local.hostname}-${local.datacenter.id}-elk02"// cfrmcloud-uat-gb00-elk02
  bt_infra_cluster     = local.facts.bt_infra_cluster
  bt_infra_network     = local.facts.bt_infra_network
  #firewall_group       = local.facts.firewall_group
  lob                  = local.facts.bt_lob
  foreman_environment  = local.facts.environment
  foreman_hostgroup    = local.facts.hostgroup
  datacenter           = local.datacenter.name
  external_facts       = local.es02facts
  os_version           = "rhel7"
  cpus                 = "4"
  memory         	   = "16192"
  additional_disks     = {
    1 = "150",
    2 = "150"
  }
}

module "elk_dev_3" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "${local.hostname}03-au"
  alias                = "${local.facts.bt_product}-${local.facts.bt_tier}-${local.hostname}-${local.datacenter.id}-elk03"//cfrmcloud-uat-gb00-elk03
  bt_infra_cluster     = local.facts.bt_infra_cluster
  bt_infra_network     = local.facts.bt_infra_network
  #firewall_group       = local.facts.firewall_group
  lob                  = local.facts.bt_lob
  foreman_environment  = local.facts.environment
  foreman_hostgroup    = local.facts.hostgroup
  datacenter           = local.datacenter.name 
  external_facts       = local.es03facts
  os_version           = "rhel7"
  cpus                 = "4"
  memory         	   = "16192"
  additional_disks     = {
    1 = "150",
    2 = "150"
  }
} 

output "elk_dev_1" {
  value = {
    "fqdn"  = module.elk_dev_1.fqdn,
    "alias" = module.elk_dev_1.alias,
    "ip"    = module.elk_dev_1.ip,
  }
}

output "elk_dev_2" {
  value = {
    "fqdn"  = module.elk_dev_2.fqdn,
    "alias" = module.elk_dev_2.alias,
    "ip"    = module.elk_dev_2.ip,
  }
}

output "elk_dev_3" {
  value = {
    "fqdn"  = module.elk_dev_3.fqdn,
    "alias" = module.elk_dev_3.alias,
    "ip"    = module.elk_dev_3.ip,
  }
}