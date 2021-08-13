terraform {
  backend "s3" {}
}

locals {
  environment = "master"
  datacenter  = "ny2"
  facts       = {
    "bt_tier" = "dev"
    "bt_env"  = "1"
  }
}

module "harbor_test_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vltchris03"
  bt_infra_network     = "ny2-autolab-app"
  bt_infra_cluster     = "ny2-aze-ntnx-16"
  os_version           = "rhel7"
  cpus                 = "4"
  memory               = "8192"
  foreman_environment  = local.environment
  foreman_hostgroup    = "BT Base Server"
  datacenter           = local.datacenter
  external_facts       = local.facts
  additional_disks     = {
    1 = "50",
    2 = "100"
  }
}

output "harbor_test_1" {
  value = {
    "fqdn"  = "${module.harbor_test_1.fqdn}",
    "ip"    = "${module.harbor_test_1.ip}",
  }
}
