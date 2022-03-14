terraform {
  backend "s3" {}
}
 
locals {
  product     = "cfrm"
  environment = "master"
  datacenter  = "ny2"
  facts       = {
    bt_artemis_version = "2.16.0"
    bt_customer = "dgbcs"
    bt_deployment_mode = "blue"
    bt_dns_role = "es"
    bt_env = ""
    bt_es_version = "7.10.2"
    bt_infra_cluster = "ny2-aze-ntnx-11"
    bt_infra_network = "ny2-autolab-app-ahv"
    bt_product = "cfrm"
    bt_product_version = "6.6"
    bt_tier = "sbx"
    bt_role = "elasticsearch"
    bt_server_mode = "es"
    cpus = "8"
    es01_hostname = "us01vles00081"
    es02_hostname = "us01vles00082"
    es03_hostname = "us01vles00083"
    foreman_hostgroup = "BT CFRM ES Artemis Server"
    memory = "30000"
    os_version = "rhel7"
  }
  es01facts    = {
    bt_customer = local.facts.bt_customer
    bt_product = local.facts.bt_product
    bt_tier = local.facts.bt_tier
    bt_env = local.facts.bt_env
    bt_product_version = local.facts.bt_product_version
    bt_artemis_version = local.facts.bt_artemis_version
    bt_es_version = local.facts.bt_es_version
    bt_role = local.facts.bt_role
    bt_dns_role = local.facts.bt_dns_role
    bt_server_mode = local.facts.bt_server_mode
    bt_server_number = "01"
    bt_deployment_mode = local.facts.bt_deployment_mode
    bt_alias = "${local.facts.bt_product}-${local.facts.bt_customer}-${local.facts.bt_tier}${local.facts.bt_env}-${local.facts.bt_server_mode}01-${local.facts.bt_deployment_mode}"
}

es02facts    = {
    bt_customer = local.facts.bt_customer
    bt_product = local.facts.bt_product
    bt_tier = local.facts.bt_tier
    bt_env = local.facts.bt_env
    bt_product_version = local.facts.bt_product_version
    bt_artemis_version = local.facts.bt_artemis_version
    bt_es_version = local.facts.bt_es_version
    bt_role = local.facts.bt_role
    bt_dns_role = local.facts.bt_dns_role
    bt_server_mode = local.facts.bt_server_mode
    bt_server_number = "02"
    bt_deployment_mode = local.facts.bt_deployment_mode
    bt_alias = "${local.facts.bt_product}-${local.facts.bt_customer}-${local.facts.bt_tier}${local.facts.bt_env}-${local.facts.bt_server_mode}02-${local.facts.bt_deployment_mode}"
}
es03facts    = {
    bt_customer = local.facts.bt_customer
    bt_product = local.facts.bt_product
    bt_tier = local.facts.bt_tier
    bt_env = local.facts.bt_env
    bt_product_version = local.facts.bt_product_version
    bt_artemis_version = local.facts.bt_artemis_version
    bt_es_version = local.facts.bt_es_version
    bt_role = local.facts.bt_role
    bt_dns_role = local.facts.bt_dns_role
    bt_server_mode = local.facts.bt_server_mode
    bt_server_number = "03"
    bt_deployment_mode = local.facts.bt_deployment_mode
    bt_alias = "${local.facts.bt_product}-${local.facts.bt_customer}-${local.facts.bt_tier}${local.facts.bt_env}-${local.facts.bt_server_mode}03-${local.facts.bt_deployment_mode}"
}
}

module "elasticsearch_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = local.facts.es01_hostname
  alias                = "${local.facts.bt_product}-${local.facts.bt_customer}-${local.facts.bt_tier}${local.facts.bt_env}-${local.facts.bt_server_mode}${local.es01facts.bt_server_number}-${local.facts.bt_deployment_mode}"
  bt_infra_network     = local.facts.bt_infra_network
  bt_infra_cluster     = local.facts.bt_infra_cluster
  os_version           = local.facts.os_version
  cpus                 = local.facts.cpus
  memory               = local.facts.memory
  foreman_environment  = local.environment
  foreman_hostgroup    = local.facts.foreman_hostgroup
  lob = "CFRM"
  datacenter           = local.datacenter
  external_facts       = local.es01facts
  additional_disks     = {
    1 = "50",
    2 = "100"
  }
}

module "elasticsearch_2" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = local.facts.es02_hostname
  alias                = "${local.facts.bt_product}-${local.facts.bt_customer}-${local.facts.bt_tier}${local.facts.bt_env}-${local.facts.bt_server_mode}${local.es02facts.bt_server_number}-${local.facts.bt_deployment_mode}"
  bt_infra_network     = local.facts.bt_infra_network
  bt_infra_cluster     = local.facts.bt_infra_cluster
  os_version           = local.facts.os_version
  cpus                 = local.facts.cpus
  memory               = local.facts.memory
  foreman_environment  = local.environment
  foreman_hostgroup    = local.facts.foreman_hostgroup
  lob = "CFRM"
  datacenter           = local.datacenter
  external_facts       = local.es02facts
  additional_disks     = {
    1 = "50",
    2 = "100"
  }
}

module "elasticsearch_3" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = local.facts.es03_hostname
  alias                = "${local.facts.bt_product}-${local.facts.bt_customer}-${local.facts.bt_tier}${local.facts.bt_env}-${local.facts.bt_server_mode}${local.es03facts.bt_server_number}-${local.facts.bt_deployment_mode}"
  bt_infra_network     = local.facts.bt_infra_network
  bt_infra_cluster     = local.facts.bt_infra_cluster
  os_version           = local.facts.os_version
  cpus                 = local.facts.cpus
  memory               = local.facts.memory
  foreman_environment  = local.environment
  foreman_hostgroup    = local.facts.foreman_hostgroup
  lob = "CFRM"
  datacenter           = local.datacenter
  external_facts       = local.es03facts
  additional_disks     = {
    1 = "50",
    2 = "100"
  }
}

output "elasticsearch_1" {
  value = {
    "fqdn"  = module.elasticsearch_1.fqdn,
    "alias" = module.elasticsearch_1.alias,
    "ip"    = module.elasticsearch_1.ip,
  }
}

output "elasticsearch_2" {
  value = {
    "fqdn"  = module.elasticsearch_2.fqdn,
    "alias" = module.elasticsearch_2.alias,
    "ip"    = module.elasticsearch_2.ip,
  }
}

output "elasticsearch_3" {
  value = {
    "fqdn"  = module.elasticsearch_3.fqdn,
    "alias" = module.elasticsearch_3.alias,
    "ip"    = module.elasticsearch_3.ip,
  }
}
 