terraform {
  backend "s3" {}
}

locals {
  lob         = "CEA"
  cluster     = "ny2-aza-ntnx-07"
  network     = "ny2-autolab-svc"
  dc          = "ny2"
  facts       = {
    "bt_product" = "${lower(local.lob)}"
  }
}

module "base_server_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlrun99"
  bt_infra_cluster     = local.cluster
  bt_infra_network     = local.network
  lob                  = local.lob
  cpus                 = "4"
  memory               = "4096"
  external_facts       = local.facts
  os_version           = "rhel7"
  foreman_environment  = "feature_CEA_4699_gitlab_auto_runner_test"
  foreman_hostgroup    = "BT Base Server"
  datacenter           = local.dc
}

output "base_server_1" {
  value = {
    "fqdn"  = "${module.base_server_1.fqdn}",
    "alias" = "${module.base_server_1.alias}",
    "ip"    = "${module.base_server_1.ip}",
  }
}
