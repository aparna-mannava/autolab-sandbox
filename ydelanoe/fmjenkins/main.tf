terraform {
  backend "s3" {}
}

locals {
  product       = "fmcloud"
  environment   = "dev"
  hostgroup     = "BT FMCLOUD FMJenkins"
  datacenter    = "ny2"
  image         = "rhel7"
  infra_cluster = "ny2-aze-ntnx-11"
  infra_network = "ny2-autolab-app-ahv"
  facts         = {
    "bt_product"        = "fmcloud"
    "bt_tier"           = "dev"
    "bt_loc"            = "ny2"
    "bt_role"           = "fmjenkins"
    "bt_env"            = "02"
  }
}

module "fmjenkins" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlfmgjnks${local.facts.bt_env}"
  alias                = "fmg-fmcloud-jenkins${local.facts.bt_env}"
  bt_infra_cluster     = local.infra_cluster
  bt_infra_network     = local.infra_network
  os_version           = local.image
  foreman_environment  = "feature_FMDO_1927"
  foreman_hostgroup    = local.hostgroup
  datacenter           = local.datacenter
  external_facts       = local.facts
  cpus                 = "4"
  memory               = "8192"
  additional_disks     = {
    1 = "200"
  }
  lob                  = local.facts.bt_product
}

output "fmjenkins" {
  value = {
    "fqdn"  = module.fmjenkins.fqdn,
    "alias" = module.fmjenkins.alias,
    "ip"    = module.fmjenkins.ip,
  }
}
