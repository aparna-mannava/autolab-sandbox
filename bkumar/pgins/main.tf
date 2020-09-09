#
# Building PG VMs for Testing
terraform {
  backend "http" {}
}
module "pg_db01" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlsndbxpg01"
  bt_infra_cluster     = "ny2-aze-ntnx-11"
  bt_infra_network     = "ny2-autolab-app-ahv"
  os_version           = "rhel7"
  foreman_environment  = "master"
  foreman_hostgroup    = "BT Postgresql DB Server"
  datacenter           = "ny2"
  lob                  = "btiq"
  additional_disks     = {
    1 = "50"
  }
  external_facts       = {
    "bt_product"       = "btiq"
    "bt_tier"          = "dev"
  }
}

output "pg_db01" {
  value = {
    "fqdn"  = "${module.pg_db01.fqdn}",
    "alias" = "${module.pg_db01.alias}",
    "ip"    = "${module.pg_db01.ip}",
  }
}
