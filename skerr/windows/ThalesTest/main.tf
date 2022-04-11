#Rebuild
terraform {
  backend "s3" {}
}

locals {
  product     = "fml"
  environment = "master"
  hostname    = "us01vwthal"
  domain      = "auto.saas-n.com"
  hostgroup   = "BT Base Windows Server"
  facts = {
    bt_product = "fmlsaas"
    bt_tier    = "dv"
    bt_role    = ""
    bt_lob     = "gbs"
  }
  datacenter = {
    name = "ny2"
    id   = "gb03"

  }
  thal001 = {
    hostname = "${local.hostname}001"
  }
}

module "thal001" {
  source              = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname            = "${local.thal001.hostname}"
  alias               = "${local.product}-${local.datacenter.id}-pr-${local.facts.bt_role}001"
  bt_infra_cluster    = "ny2-aze-ntnx-12"
  bt_infra_network    = "ny2-autolab-app-ahv"
  os_version          = "win2019"
  cpus                = "2"
  memory              = "8192"
  external_facts      = "${local.facts}"
  foreman_environment = "${local.environment}"
  foreman_hostgroup   = "${local.hostgroup}"
  datacenter          = "${local.datacenter.name}"
  lob                 = "GBS"
}

output "thal001" {
  value = {
    "fqdn"  = "${module.thal001.fqdn}",
    "alias" = "${module.thal001.alias}",
    "ip"    = "${module.thal001.ip}",
  }
}
