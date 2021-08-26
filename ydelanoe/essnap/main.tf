terraform {
  backend "s3" {}
}

locals {
  lob           = "FMCLOUD"
  environment   = "master"
  hostgroup     = "BT FM Cloud ES Snapshot Server"
  datacenter    = "ny2"
  image         = "rhel7"
  infra_cluster = "ny2-azd-ntnx-10"
  infra_network = "ny2-autolab-app-ahv"
  facts         = {
    "bt_product"        = "fmcloud"
    "bt_tier"           = "dev"
    "bt_loc"            = "ny2"
    "bt_role"           = "essnap"
    "bt_env"            = "1"
  }
}

module "es_snap" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlfm${local.facts.bt_role}${local.facts.bt_env}"
  alias                = "fm-${local.facts.bt_loc}-${local.facts.bt_tier}-${local.facts.bt_role}-${local.facts.bt_env}"
  bt_infra_cluster     = local.infra_cluster
  bt_infra_network     = local.infra_network
  os_version           = local.image
  foreman_environment  = local.environment
  foreman_hostgroup    = local.hostgroup
  datacenter           = local.datacenter
  external_facts       = local.facts
  cpus                 = "4"
  memory               = "6144"
  additional_disks     = {
    1 = "550"
  }
  lob                  = local.lob
}

output "es_snap" {
  value = {
    "fqdn"  = module.es_snap.fqdn,
    "alias" = module.es_snap.alias,
    "ip"    = module.es_snap.ip,
  }
}
