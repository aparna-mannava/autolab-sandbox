terraform {
  backend "s3" {}
}

locals {
  environment = "feature_CEA_10866_harbor_storage_quotas"
  datacenter  = "ny2"
  facts       = {
    "bt_tier" = "dev"
    "bt_env"  = "1"
  }
}

module "harbor_test_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vltchris05"
  bt_infra_network     = "ny2-autolab-app-ahv"
  bt_infra_cluster     = "ny5-aza-ntnx-19"
  lob                  = "CEA"
  os_version           = "rhel7"
  cpus                 = "4"
  memory               = "8192"
  foreman_environment  = local.environment
  foreman_hostgroup    = "BT Base Server"
  datacenter           = local.datacenter
  external_facts       = local.facts
  additional_disks     = {
    1 = "100",
    2 = "100"
  }
}


output "harbor_test_1" {
  value = {
    "fqdn"  = "${module.harbor_test_1.fqdn}",
    "ip"    = "${module.harbor_test_1.ip}",
  }
}
