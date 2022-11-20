terraform {
  backend "s3" {}
}

locals {
//destroy
    facts       = {
      bt_customer           = "ny2"
      bt_product            = "cfrmcloud"
      bt_lob                = "CFRM"
      bt_tier               = "dev"
      bt_env                = "06"
      bt_role               = "opensearch"
      bt_infra_network      = "ny2-autolab-app-ahv"
      bt_infra_cluster      = "ny2-aze-ntnx-12"
      hostgroup             = "BT CFRM CLOUD opensearch"
      environment           = "master"
      bt_opensearch_version = "1.2.3"
      bt_opensearch_nodes   = ["us01vlcfrmops06"]
      hostname              = "us01vlcfrm"
    }
    datacenter = {
      name = "ny2"
      id   = "ny2"
  }
}

module "basedev_ny2_1" {
  source                = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  hostname              = "${local.facts.hostname}ops${local.facts.bt_env}"
  alias                 = "${local.facts.bt_product}-${local.datacenter.id}-${local.facts.bt_tier}-${local.facts.bt_role}-${local.facts.bt_env}"//   cfrmcloud-ny2-dev-opensearch-06.autolab.saas-n.com
  bt_infra_cluster      = local.facts.bt_infra_cluster
  bt_infra_network      = local.facts.bt_infra_network
  //firewall_group       = local.facts.firewall_group
  lob                   = local.facts.bt_lob
  foreman_environment   = local.facts.environment
  foreman_hostgroup     = local.facts.hostgroup
  datacenter            = local.datacenter.name
  external_facts        = local.facts
  os_version            = "rhel8"
  cpus                  = "2"
  memory         	      = "2048"
  additional_disks     = {
    1 = "20"
  }
}

output "basedev_ny2_1" {
  value = {
    "fqdn"  = module.basedev_ny2_1.fqdn,
    "alias" = module.basedev_ny2_1.alias,
    "ip"    = module.basedev_ny2_1.ip,
  }
}