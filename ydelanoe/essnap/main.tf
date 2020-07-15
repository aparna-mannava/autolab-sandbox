terraform {
  backend "http" {}
}


locals {
  product       = "fmcloud"
  environment   = "feature_FMDO_1740"
  hostgroup     = "BT FM Cloud ES Snapshot Server"
  datacenter    = "ny2"
  image         = "rhel7"
  infra_cluster = "ny2-aza-vmw-autolab"
  infra_network = "ny2-autolab-app"
  facts         = {
    "bt_product"        = "fmcloud"
    "bt_tier"           = "dev"
    "bt_loc"            = "ny2"
    "bt_role"           = "essnap"
  }
}

module "es_snap" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlfmessnap"
  alias                = "fm-${local.facts.bt_loc}-${local.facts.bt_tier}-${local.facts.bt_role}"
  bt_infra_cluster     = local.infra_cluster
  bt_infra_network     = local.infra_network
  os_version           = local.image
  foreman_environment  = local.environment
  foreman_hostgroup    = local.hostgroup
  datacenter           = local.datacenter
  external_facts       = "${merge(
    local.facts,
    map(
      "bt_env", "01",
      )
  )}"
  cpus                 = "4"
  memory               = "6144"
  additional_disks     = {
    1 = "150"
  }
  lob                  = local.facts.bt_product
}

output "es_snap" {
  value = {
    "fqdn"  = "${module.es_snap.fqdn}",
    "alias" = "${module.es_snap.alias}",
    "ip"    = "${module.es_snap.ip}",
  }
}

module "es_snap2" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlfmessnap2"
  alias                = "fm-${local.facts.bt_loc}-${local.facts.bt_tier}-${local.facts.bt_role}2"
  bt_infra_cluster     = local.infra_cluster
  bt_infra_network     = local.infra_network
  os_version           = local.image
  foreman_environment  = local.environment
  foreman_hostgroup    = local.hostgroup
  datacenter           = local.datacenter
  external_facts       = "${merge(
    local.facts,
    map(
      "bt_env", "02",
      )
  )}"
  cpus                 = "4"
  memory               = "6144"
  additional_disks     = {
    1 = "150"
  }
  lob                  = local.facts.bt_product
}

output "es_snap2" {
  value = {
    "fqdn"  = "${module.es_snap.fqdn}",
    "alias" = "${module.es_snap.alias}",
    "ip"    = "${module.es_snap.ip}",
  }
}
