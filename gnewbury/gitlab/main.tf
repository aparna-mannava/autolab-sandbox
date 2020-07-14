terraform {
  backend "http" {}
}

locals {
  product     = "inf"
  environment = "feature_CLOUD_66563_inf_gitlab_aws"
  datacenter  = "ny2"
  hostgroup   = "BT INF Gitlab Server"
  facts = {
    "bt_product" = local.product
    "bt_role"    = "gitlab"
    "bt_tier"    = "test"
  }
  cluster = "ny2-aza-vmw-autolab"
  network = "ny2-autolab-app"
  lob     = "INF"
  os      = "rhel7"
  memory  = "2048"
  cpus    = "2"

  inf_ny2_gitlab01 = {
    hostname = "${local.hostname_part}001"
    alias    = "${local.product}-${local.datacenter}-${local.role}01"
  }

}

module "inf_ny2_gitlab01" {
  source              = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname            = local.inf_ny2_gitlab01.hostname
  alias               = local.inf_ny2_gitlab01.alias
  bt_infra_cluster    = local.cluster
  bt_infra_network    = local.network
  os_version          = local.os
  cpus                = local.cpus
  memory              = local.memory
  external_facts      = local.facts
  foreman_environment = local.environment
  foreman_hostgroup   = local.hostgroup
  datacenter          = local.datacenter
  lob                 = local.lob
}

output "inf_ny2_gitlab01" {
  value = {
    "fqdn"  = module.inf_ny2_gitlab01.fqdn,
    "alias" = module.inf_ny2_gitlab01.alias,
    "ip"    = module.inf_ny2_gitlab01.ip,
  }
}
