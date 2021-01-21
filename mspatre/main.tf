# Build the IR PostgreSQL Database server

terraform {
  backend "s3" {}
}

locals {
facts = {
"bt_product" = "ir"
"bt_tier" = "dev"
"bt_env" = "1"
}
}

module "db_server1" {
source = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
hostname = "us01vlirdbpg001"
alias = "pgdb-irtest-pg01"
bt_infra_network = "ny2-autolab-db"
bt_infra_cluster = "ny2-aza-vmw-autolab"
cpus = 2
memory = 8096
os_version = "rhel7"
lob = "dev"
external_facts       = local.facts
foreman_environment = "master"
foreman_hostgroup = "BT IR PG"
datacenter = "ny2"
additional_disks = {
1 = "100",
2 = "50",
3 = "50",
}
}

output "db_server1" {
  value = {
    "fqdn"  = "${module.db_server1.fqdn}",
    "alias" = "${module.db_server1.alias}",
    "ip"    = "${module.db_server1.ip}",
  }
}


