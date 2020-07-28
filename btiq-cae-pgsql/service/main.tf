terraform {
  backend "s3" {}
}

module "db_server1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlbtiqpgs01"
  alias                = "btiq-ingest-db"
  bt_infra_network     = "ny2-autolab-db"
  bt_infra_cluster     = "ny2-aza-vmw-autolab"
  cpus                 = 4
  memory               = 4096
  os_version           = "rhel7"
  foreman_environment  = "master"
  foreman_hostgroup    = "BT Postgresql DB Server"
  datacenter           = "ny2"
  additional_disks     = {
    1 = "50",
    2 = "50",
  }
}

output "db_server1" {
  value = {
    "fqdn"  = "${module.db_server1.fqdn}",
    "alias" = "${module.db_server1.alias}",
    "ip"    = "${module.db_server1.ip}",
  }
}