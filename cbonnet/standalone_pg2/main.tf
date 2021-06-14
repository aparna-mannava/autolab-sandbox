terraform {
  backend "s3" {}
}

locals {
  product = "fmcloud"
  facts = {
    "bt_tier" = "autolab" ###### THIS IS YOUR TIER
    "bt_env" = "1" ###### THIS IS YOUR ENV NUMBER
  }
}

module "db_server1" {
  source = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname = "us01vlfmpg00002"
  alias = "${local.product}-${local.facts.bt_tier}${local.facts.bt_env}-pg02"
  bt_infra_network = "ny2-autolab-db-ahv"
  bt_infra_cluster = "ny5-azc-ntnx-16"
  cpus = 2
  memory = 4096
  os_version = "rhel7"
  lob = local.product
  external_facts       = local.facts
  foreman_environment = "master"
  foreman_hostgroup = "BT Postgresql DB Server" ###### THIS IS A GENERIC DB ROLE
  datacenter = "ny2"
  additional_disks = {
    1 = "50", ######. THIS SPACE GOES TO ROOTVG
    2 = "50", ####### THIS GOES TO $PGDATA
  }
}

output "db_server1" {
  value = {
    "fqdn" = "${module.db_server1.fqdn}",
    "alias" = "${module.db_server1.alias}",
    "ip" = "${module.db_server1.ip}",
  }
}