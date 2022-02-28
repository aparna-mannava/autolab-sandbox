terraform {
  backend "s3" {}
}

locals {
  product     = "inf"
  environment = "master"
  datacenter  = "ny2"
  facts = {
    "bt_tier" = "ny2"
    "bt_product" = "cloud"
  }
}

module "ebouzinis-dev-machine" {
  source              = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname            = "us01vlebdev1"
  alias               = "ebouzinis-dev-1"
  bt_infra_cluster    = "ny2-aza-ntnx-05"
  bt_infra_network    = "ny2-autolab-app-ahv"
  os_version          = "rhel8"
  cpus                = "4"
  lob                 = "CLOUD"
  memory              = "16384"
  foreman_environment = local.environment
  foreman_hostgroup   = "BT Base Server"
  datacenter          = local.datacenter
  external_facts      = local.facts
}