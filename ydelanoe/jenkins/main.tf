terraform {
  backend "s3" {}
}

locals {
  product     = "FMCLOUD"
  environment = "feature_CFMS_9006"
  datacenter  = "ny2"
  facts       = {
    "bt_product" = "fmcloud"
    "bt_tier"    = "dev"
    "bt_env"     = "1"
    "bt_role"    = "gtsjenkins"
  }
}

module "gtxjenkins1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlgtxjnks1"
  bt_infra_cluster     = "ny2-aze-ntnx-11"
  bt_infra_network     = "ny2-autolab-app-ahv"
  os_version           = "rhel7"
  cpus                 = "2"
  memory               = "8192"
  lob                  = local.product
  foreman_environment  = local.environment
  foreman_hostgroup    = "BT FMCLOUD GTXJenkins"
  datacenter           = local.datacenter
  external_facts       = local.facts
  additional_disks     = {
    1 = "300"
  }
}

output "gtxjenkins1" {
  value = {
    "fqdn"  = "${module.gtxjenkins1.fqdn}",
    "ip"    = "${module.gtxjenkins1.ip}",
  }
}
