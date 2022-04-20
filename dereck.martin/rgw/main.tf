terraform {
  backend "s3" {}
}

locals {
  lob         = "cea"
  cluster     = "ny2-aze-ntnx-12"
  network     = "ny2-autolab-svc"
  dc          = "ny2"
  facts       = {
    "bt_product" = "${lower(local.lob)}"
  }
}

module "rgw_server_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlrgw9999"
  bt_infra_cluster     = local.cluster
  bt_infra_network     = local.network
  lob                  = local.lob
  cpus                 = "4"
  memory               = "8192"
  external_facts       = local.facts
  os_version           = "rhel7"
  foreman_environment  = "master"
  foreman_hostgroup    = "BT Base Server"
  datacenter           = local.dc
  additional_disks     = {
    1 = "500",
  }
}