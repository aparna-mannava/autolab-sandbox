terraform {
  backend "s3" {}
}

locals {
  product     = "fmlsaas"
  environment = "master"
  hostname    = "us01vwskerr01"
  domain      = "saas-p.com"
  hostgroup   = "BT FML Base Windows"
  facts = {
    bt_product = "fmlsaas"
    bt_tier    = "dv"
    bt_role    = "saaw"
    bt_customer = "fmlsaas"
 }
  datacenter = {
    name = "ny2"
    id   = "ny2"
  }
  sass = {
    hostname = "${local.hostname}"
  }
}

module "servicemm" {
  source              = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  hostname            = "${local.hostname}"
  alias               = "fm-mm-${local.facts.bt_role}-${local.facts.bt_tier}"
  bt_infra_cluster    = "ny5-aza-ntnx-14"
  bt_infra_network    = "ny2-autolab-app-ahv"
  os_version          = "win2022"
  cpus                = "2"
  memory              = "8192"
  external_facts      = "${local.facts}"
  foreman_environment = "${local.environment}"
  foreman_hostgroup   = "${local.hostgroup}"
  datacenter          = "${local.datacenter.name}"
  additional_disks     = {
    1 = "50"
}
}

output "servicemm" {
  value = {
    "fqdn"  = "${module.servicemm.fqdn}",
    "alias" = "${module.servicemm.alias}",
    "ip"    = "${module.servicemm.ip}",
  }
}