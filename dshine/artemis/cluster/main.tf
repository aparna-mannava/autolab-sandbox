terraform {
  backend "s3" {}
}
 
locals {
 
    hostname           = "us01vlcfrm"
    facts       = {
      bt_customer        = "ny2"
      bt_product         = "cfrmcloud"
      bt_lob             = "CFRM"
      bt_ic_version      = "660_SP2"
      bt_tier            = "dev" //
      bt_env             = "01" //
      bt_role            = "artemis" //
      bt_artemis_version = "2.16.0" // Artemis service version
      bt_infra_network   = "ny2-autolab-app-ahv" //
      bt_infra_cluster   = "ny2-aze-ntnx-12"
      hostgroup          = "BT CFRM CLOUD Artemis Cluster Servers" // Foreman hostgroup for Standalone Artemis only servers
      environment        = "feature_CFRMCLOUD_2629_opensearch_rhel8" // Bitbucket Puppet controlrepo branch name
      bt_artemis1_fqdn   = "${local.hostname}01-dv" //us01vlcfrmc01 
      bt_artemis2_fqdn   = "${local.hostname}02-dv" //us01vlcfrmc02
      bt_artemis3_fqdn   = "${local.hostname}03-dv" //us01vlcfrmc03
    }
    datacenter = {
      name = "ny2"
      id   = "ny2"
  }

    art01facts    = {
      "bt_customer"               = local.facts.bt_customer
      "bt_product"                = local.facts.bt_product
      "bt_tier"                   = local.facts.bt_tier
      "bt_env"                    = local.facts.bt_env
      "bt_role"                   = local.facts.bt_role
      "bt_artemis_version"        = local.facts.bt_artemis_version
      "bt_artemis1_fqdn"          = local.facts.bt_artemis1_fqdn
     }
    art02facts    = {
      "bt_customer"               = local.facts.bt_customer
      "bt_product"                = local.facts.bt_product
      "bt_tier"                   = local.facts.bt_tier
      "bt_env"                    = local.facts.bt_env
      "bt_role"                   = local.facts.bt_role
      "bt_artemis_version"        = local.facts.bt_artemis_version
      "bt_artemis2_fqdn"          = local.facts.bt_artemis2_fqdn
     }
    art03facts    = {
      "bt_customer"               = local.facts.bt_customer
      "bt_product"                = local.facts.bt_product
      "bt_tier"                   = local.facts.bt_tier
      "bt_env"                    = local.facts.bt_env
      "bt_role"                   = local.facts.bt_role
      "bt_artemis_version"        = local.facts.bt_artemis_version
      "bt_artemis3_fqdn"          = local.facts.bt_artemis3_fqdn
    }
}
 
module "artemisdev_1" {
  source               = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  hostname             = "${local.hostname}artc1" // us01vlcfrmartc1
  alias                = "${local.facts.bt_product}-${local.datacenter.id}-${local.facts.bt_tier}-${local.facts.bt_role}-cluster-01"//   cfrmcloud-ny2-dev-artemis-cluster-01.autolab.saas-n.com
  bt_infra_cluster     = local.facts.bt_infra_cluster
  bt_infra_network     = local.facts.bt_infra_network
  //firewall_group       = local.facts.firewall_group
  lob                  = local.facts.bt_lob
  foreman_environment  = local.facts.environment
  foreman_hostgroup    = local.facts.hostgroup
  datacenter           = local.datacenter.name
  external_facts       = local.facts
  os_version           = "rhel8"
  cpus                 = "2"
  memory               = "4096"
  additional_disks     = {
    1 = "100"
  }
}

module "artemisdev_2" {
  source               = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  hostname             = "${local.hostname}artc2" // us01vlcfrmartc2
  alias                = "${local.facts.bt_product}-${local.datacenter.id}-${local.facts.bt_tier}-${local.facts.bt_role}-cluster-02"//   cfrmcloud-ny2-dev-artemis-cluster-02.autolab.saas-n.com
  bt_infra_cluster     = local.facts.bt_infra_cluster
  bt_infra_network     = local.facts.bt_infra_network
  //firewall_group       = local.facts.firewall_group
  lob                  = local.facts.bt_lob
  foreman_environment  = local.facts.environment
  foreman_hostgroup    = local.facts.hostgroup
  datacenter           = local.datacenter.name
  external_facts       = local.facts
  os_version           = "rhel8"
  cpus                 = "2"
  memory               = "4096"
  additional_disks     = {
    1 = "100"
  }
}

module "artemisdev_3" {
  source               = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  hostname             = "${local.hostname}artc3" // us01vlcfrmartc3
  alias                = "${local.facts.bt_product}-${local.datacenter.id}-${local.facts.bt_tier}-${local.facts.bt_role}-cluster-03"//   cfrmcloud-ny2-dev-artemis-cluster-03.autolab.saas-n.com
  bt_infra_cluster     = local.facts.bt_infra_cluster
  bt_infra_network     = local.facts.bt_infra_network
  //firewall_group       = local.facts.firewall_group
  lob                  = local.facts.bt_lob
  foreman_environment  = local.facts.environment
  foreman_hostgroup    = local.facts.hostgroup
  datacenter           = local.datacenter.name
  external_facts       = local.facts
  os_version           = "rhel8"
  cpus                 = "2"
  memory               = "4096"
  additional_disks     = {
    1 = "100"
  }
}
 
output "artemisdev_1" {
  value = {
    "fqdn"  = module.artemisdev_1.fqdn,
    "alias" = module.artemisdev_1.alias,
    "ip"    = module.artemisdev_1.ip,
  }
}

output "artemisdev_2" {
  value = {
    "fqdn"  = module.artemisdev_2.fqdn,
    "alias" = module.artemisdev_2.alias,
    "ip"    = module.artemisdev_2.ip,
  }
}

output "artemisdev_3" {
  value = {
    "fqdn"  = module.artemisdev_3.fqdn,
    "alias" = module.artemisdev_3.alias,
    "ip"    = module.artemisdev_3.ip,
  }
}