terraform {
  backend "s3" {}
}

locals {
  product     = "fmcloud"
  environment = "feature_CFMS_9005"
  datacenter  = "ny2"
  facts       = {
    "bt_tier" = "dev"
    "bt_env"  = "1"
    "bt_role" = "oradb19c"
  }
}

module "fmgoradb" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlfmgoradb"
  bt_infra_cluster     = "ny2-aze-ntnx-11"
  bt_infra_network     = "ny2-autolab-app-ahv"
  os_version           = "rhel8"
  cpus                 = "2"
  memory               = "8192"
  lob                  = local.product
  foreman_environment  = local.environment
  foreman_hostgroup    = "BT FMCLOUD Oracle19c"
  datacenter           = local.datacenter
  external_facts       = local.facts
  additional_disks     = {
    1 = "150"
  }
}

output "fmgoradb" {
  value = {
    "fqdn"  = "${module.fmgoradb.fqdn}",
    "ip"    = "${module.fmgoradb.ip}",
  }
}
