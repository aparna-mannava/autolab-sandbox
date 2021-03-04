terraform {
  backend "http" {}
}

locals {
  facts       = {
    "bt_tier" = "dev"
    "bt_env"  = "1"
    "bt_product" = "inf"
  }
}

module "db_server1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlsslab"
  alias                = "bt-${local.facts.bt_tier}${local.facts.bt_env}-ss01"
  bt_infra_network     = "ny2-autolab-app-ahv"
  bt_infra_cluster     = "ny2-azd-ntnx-15"
  cpus                 = 2
  memory               = 8096 
  os_version           = "rhel7"
  external_facts       = local.facts
  lob       	       = "PMX"
  foreman_environment  = "master"
  foreman_hostgroup    = "BT Streamsets Server"
  datacenter           = "ny2"
  additional_disks     = {
    1 = "100",
  }
}

output "ss_server1" {
  value = {
    "fqdn"  = "${module.db_server1.fqdn}",
    "alias" = "${module.db_server1.alias}",
    "ip"    = "${module.db_server1.ip}",
  }
}
