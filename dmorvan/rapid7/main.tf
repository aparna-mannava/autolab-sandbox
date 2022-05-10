terraform {
  backend "s3" {}
}

locals {
  lob         = "CLOUD"
  cluster     = "ny2-aze-ntnx-12"
  network     = "ny2-autolab-svc"
  dc          = "ny2"
  facts       = {
    "bt_product" = "${lower(local.lob)}"
  }
}

module "rapid7" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlrpd7002"
  bt_infra_cluster     = local.cluster
  bt_infra_network     = local.network
  lob                  = local.lob
  cpus                 = "2"
  memory               = "2048"
  external_facts       = local.facts
  os_version           = "rhel8"
  foreman_environment  = "master"
  foreman_hostgroup    = "BT Base Server"
  datacenter           = local.dc
}