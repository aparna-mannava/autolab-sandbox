terraform {
  backend "s3" {}
}

locals {
  lob           = "FMCLOUD"
  environment   = "dev"
  hostgroup     = "BT FMCLOUD ReportPortal"
  datacenter    = "ny2"
  image         = "rhel8"
  infra_cluster = "ny5-azc-ntnx-16"
  infra_network = "ny2-autolab-db"
  facts         = {
    "bt_product"        = "fmcloud"
    "bt_tier"           = "dev"
    "bt_loc"            = "ny2"
    "bt_role"           = "reportportal"
    "bt_env"            = "01"
  }
}

module "rp_server" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlfmrp001"
  alias                = "fm-dev-reportportal1"
  bt_infra_cluster     = local.infra_cluster
  bt_infra_network     = local.infra_network
  os_version           = local.image
  foreman_environment  = "feature_FMDO_1935"
  foreman_hostgroup    = local.hostgroup
  datacenter           = local.datacenter
  external_facts       = local.facts
  cpus                 = "2"
  memory               = "8192"
  additional_disks     = {
    1 = "250"
  }
  lob                  = local.lob
}

output "goa_server" {
  value = {
    "fqdn"  = "${module.rp_server.fqdn}",
    "alias" = "${module.rp_server.alias}",
    "ip"    = "${module.rp_server.ip}",
  }
}
