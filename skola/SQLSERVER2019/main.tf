terraform {
  backend "s3" {}
}

locals {
  product        = "pcmiq"
  environment    = "master"
  datacenter     = "ny2"
  hostname       = "us01vwpcmiqdb11"
  hostgroup      = "BT MSSQL 2019 Server"
  facts          = {
    "bt_env"          = "1"
    "bt_product"      = "pcmiq"
    "bt_tier"         = "dev"
    "bt_role"         = "mssql"
  }
}


module "pcmiq_103053" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "${local.hostname}"
  alias                = "pcmiq-pci-ppd-agent-db01"
  bt_infra_cluster     = "ny5-aza-ntnx-14"
  bt_infra_network     = "ny2-autolab-app-ahv"
  lob                  = "DGB"
  os_version           = "win2019"
  cpus                 = "4"
  memory               = "16384"
  external_facts       = "${local.facts}"
  foreman_environment  = "${local.environment}"
  foreman_hostgroup    = "${local.hostgroup}"
  datacenter           = "${local.datacenter}"
  additional_disks     = {
    1 = "200",
    2 = "200",
    3 = "200",
    4 = "200",
    5 = "200",
    6 = "200"
  }
}

output "pcmiq_103053" {
  value = {
    "fqdn"  = "${module.pcmiq_103053.fqdn}",
    "alias" = "${module.pcmiq_103053.alias}",
    "ip"    = "${module.pcmiq_103053.ip}",
  }
}
