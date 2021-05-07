terraform {
  backend "s3" {}
}

locals {
  product     = "FMCLOUD"
  environment = "feature_CFMS_9008"
  datacenter  = "ny2"
  facts       = {
    "bt_tier" = "dev"
    "bt_env"  = "01"
    "bt_role" = "gtx"
  }
}

module "fmggtx01" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlfmggtx01"
  alias                = "fmg-gtx-01"
  bt_infra_cluster     = "ny2-aze-ntnx-11"
  bt_infra_network     = "ny2-autolab-app-ahv"
  os_version           = "rhel8"
  cpus                 = "4"
  memory               = "16384"
  lob                  = local.product
  foreman_environment  = local.environment
  foreman_hostgroup    = "BT FMCLOUD GTX"
  datacenter           = local.datacenter
  external_facts       = local.facts
  additional_disks     = {
    1 = "200"
  }
}

output "fmggtx01" {
  value = {
    "fqdn"  = "${module.fmggtx01.fqdn}",
    "ip"    = "${module.fmggtx01.ip}",
  }
}
