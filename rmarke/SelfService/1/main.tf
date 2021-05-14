terraform {
  backend "s3" {}
}

locals {
  product     = "fml"
  environment = "master"
  hostname    = "us01vwrmssa"
  hostgroup   = "BT FML Self Service"
  lob         = "fml"
  facts = {
    bt_product = "fmlsaas"
    bt_tier    = "ts"
    bt_role    = "adss"
  }
  datacenter = {
    name = "ny2"
  }
  adss001 = {
    hostname = "${local.hostname}101"
  }
}

module "adss001" {
  source              = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname            = "${local.adss001.hostname}"
  alias               = "${local.product}-${local.datacenter.name}-ts-${local.facts.bt_role}101"
  lob                 = local.lob
  bt_infra_cluster    = "ny2-aza-ntnx-07"
  bt_infra_network    = "ny2-autolab-app-ahv"
  os_version          = "win2019"
  cpus                = "1"
  memory              = "4096"
  external_facts      = "${local.facts}"
  foreman_environment = "${local.environment}"
  foreman_hostgroup   = "${local.hostgroup}"
  datacenter          = "${local.datacenter.name}"
  additional_disks     = {
    1 = "50"
}
}

output "adss001" {
  value = {
    "fqdn"  = "${module.adss001.fqdn}",
    "alias" = "${module.adss001.alias}",
    "ip"    = "${module.adss001.ip}",
  }
}
