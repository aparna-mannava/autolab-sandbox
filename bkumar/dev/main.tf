terraform {
  backend "http" {}
}

locals {
  cluster             = "ny2-azd-ntnx-10"
  network             = "ny2-autolab-db-ahv"
  lob                 = "btiq"
  facts = {
    "bt_tier"         = "dev"
    "bt_product"      = "btiq"
  }
}

module "db_pg01" {
  source = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname = "us01vlbtiqpg01"
  alias = "btiq-pg01"
  bt_infra_cluster = local.cluster
  bt_infra_network = local.network
  cpus = 2
  memory = 8096
  os_version = "rhel7"
  lob = local.lob
  external_facts = local.facts
  foreman_environment = "master"
  foreman_hostgroup = "BT Postgresql DB Server"
  datacenter = "ny2"
  additional_disks = {
    1 = "100",
    2 = "500",
  }
}

output "pg01" {
  value = {
    "fqdn" = "${module.db_pg01.fqdn}",
    "alias" = "${module.db_pg01.alias}",
    "ip" = "${module.db_pg01.ip}",
  }
}
