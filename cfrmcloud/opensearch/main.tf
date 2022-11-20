terraform {
  backend "s3" {}
}
 
 
locals {
    hostname    = "us01vlcfrm"
    facts       = {
      bt_customer             = "ny2"                 // mandatory
      bt_product              = "cfrmcloud"           // mandatory
      bt_lob                  = "CFRM"                // mandatory
      bt_tier                 = "dev"                 // mandatory
      bt_env                  = "02"                  // mandatory
      bt_role                 = "opensearch"          // mandatory
      bt_infra_network        = "ny2-autolab-app-ahv"
      bt_infra_cluster        = "ny2-aze-ntnx-12"
      hostgroup               = "BT CFRM CLOUD opensearch cluster"  // Foreman hostgroup for Standalone Elasticsearch only servers in NY2.saas-n domain
      environment             = "master" // Bitbucket Puppet controlrepo branch name
      bt_opensearch_version   = "1.2.3"              // Opensearch service version
      bt_opensearch_nodes     = ["us01vlcfrmopsc1.saas-n.com","us01vlcfrmopsc2.saas-n.com","us01vlcfrmopsc3.saas-n.com"]         // mandatory
    }
    datacenter = {
      name = "ny2"
      id   = "ny2"
  }
    ops01facts    = {
      "bt_customer"               = local.facts.bt_customer
      "bt_product"                = local.facts.bt_product
      "bt_tier"                   = local.facts.bt_tier
      "bt_env"                    = local.facts.bt_env
      "bt_role"                   = local.facts.bt_role
      "bt_opensearch_version"     = local.facts.bt_opensearch_version
      "bt_opensearch_nodes"       = local.facts.bt_opensearch_nodes
     }
    ops02facts    = {
      "bt_customer"               = local.facts.bt_customer
      "bt_product"                = local.facts.bt_product
      "bt_tier"                   = local.facts.bt_tier
      "bt_env"                    = local.facts.bt_env
      "bt_role"                   = local.facts.bt_role
      "bt_opensearch_version"     = local.facts.bt_opensearch_version
      "bt_opensearch_nodes"       = local.facts.bt_opensearch_nodes
     }
    ops03facts    = {
      "bt_customer"               = local.facts.bt_customer
      "bt_product"                = local.facts.bt_product
      "bt_tier"                   = local.facts.bt_tier
      "bt_env"                    = local.facts.bt_env
      "bt_role"                   = local.facts.bt_role
      "bt_opensearch_version"     = local.facts.bt_opensearch_version
      "bt_opensearch_nodes"       = local.facts.bt_opensearch_nodes
    }
}
 
module "opensearch_1" {
  source               = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  alias                = "${local.facts.bt_product}-${local.datacenter.id}-${local.facts.bt_tier}-${local.facts.bt_role}-ops01"//   cfrmcloud-ny2-dev-opensearch-ops01.saas-n.com
  hostname             = "${local.hostname}opsc1" // us01vlcfrmopsc1 , maximum of 15 characters
  bt_infra_cluster     = local.facts.bt_infra_cluster
  bt_infra_network     = local.facts.bt_infra_network
  //firewall_group       = local.facts.firewall_group
  lob                  = local.facts.bt_lob
  foreman_environment  = local.facts.environment
  foreman_hostgroup    = local.facts.hostgroup
  datacenter           = local.datacenter.name
  external_facts       = local.ops01facts
  os_version           = "rhel8"
  cpus                 = "4"
  memory             = "16192"
  additional_disks     = {
    1 = "150",
    2 = "150"
  }
}
 
module "opensearch_2" {
  source               = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  alias                = "${local.facts.bt_product}-${local.datacenter.id}-${local.facts.bt_tier}-${local.facts.bt_role}-ops02"//   cfrmcloud-ny2-dev-opensearch-ops02.saas-n.com
  hostname             = "${local.hostname}opsc2" // us01vlcfrmopsc2 , maximum of 15 characters
  bt_infra_cluster     = local.facts.bt_infra_cluster
  bt_infra_network     = local.facts.bt_infra_network
  //firewall_group       = local.facts.firewall_group
  lob                  = local.facts.bt_lob
  foreman_environment  = local.facts.environment
  foreman_hostgroup    = local.facts.hostgroup
  datacenter           = local.datacenter.name
  external_facts       = local.ops02facts
  os_version           = "rhel8"
  cpus                 = "4"
  memory             = "16192"
  additional_disks     = {
    1 = "150",
    2 = "150"
  }
}
 
module "opensearch_3" {
  source               = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  alias                = "${local.facts.bt_product}-${local.datacenter.id}-${local.facts.bt_tier}-${local.facts.bt_role}-ops03"//   cfrmcloud-ny2-dev-opensearch-ops03.saas-n.com
  hostname             = "${local.hostname}opsc3" // us01vlcfrmopsc3 , maximum of 15 characters
  bt_infra_cluster     = local.facts.bt_infra_cluster
  bt_infra_network     = local.facts.bt_infra_network
  //firewall_group       = local.facts.firewall_group
  lob                  = local.facts.bt_lob
  foreman_environment  = local.facts.environment
  foreman_hostgroup    = local.facts.hostgroup
  datacenter           = local.datacenter.name
  external_facts       = local.ops03facts
  os_version           = "rhel8"
  cpus                 = "4"
  memory             = "16192"
  additional_disks     = {
    1 = "150",
    2 = "150"
  }
}
 
output "opensearch_1" {
  value = {
    "fqdn"  = module.opensearch_1.fqdn,
    "alias" = module.opensearch_1.alias,
    "ip"    = module.opensearch_1.ip,
  }
}
 
output "opensearch_2" {
  value = {
    "fqdn"  = module.opensearch_2.fqdn,
    "alias" = module.opensearch_2.alias,
    "ip"    = module.opensearch_2.ip,
  }
}
 
output "opensearch_3" {
  value = {
    "fqdn"  = module.opensearch_3.fqdn,
    "alias" = module.opensearch_3.alias,
    "ip"    = module.opensearch_3.ip,
  }
}