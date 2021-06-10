terraform {
  backend "s3" {}
}

locals {
  product       = "fmcloud"
  environment   = "dev"
  hostgroup     = "BT FMCLOUD InfluxDB"
  datacenter    = "ny2"
  image         = "rhel8"
  infra_cluster = "ny2-aze-ntnx-12"
  infra_network = "ny2-autolab-app-ahv"
  facts         = {
    "bt_product"        = "fmcloud"
    "bt_tier"           = "dev"
    "bt_loc"            = "ny2"
    "bt_role"           = "influxdb"
    "bt_env"            = "1"
  }
}

module "influxdb" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlfmgifxdb${local.facts.bt_env}"
  alias                = "fmg-influxdb-${local.facts.bt_env}"
  bt_infra_cluster     = local.infra_cluster
  bt_infra_network     = local.infra_network
  os_version           = local.image
  foreman_environment  = "feature_FMDO_1927"
  foreman_hostgroup    = local.hostgroup
  datacenter           = local.datacenter
  external_facts       = local.facts
  cpus                 = "4"
  memory               = "8192"
  lob                  = local.facts.bt_product
}

output "influxdb" {
  value = {
    "fqdn"  = module.influxdb.fqdn,
    "alias" = module.influxdb.alias,
    "ip"    = module.influxdb.ip,
  }
}
