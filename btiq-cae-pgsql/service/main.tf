terraform {
  backend "s3" {}
}
module "postgre_btiq" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlbtiqpgs01"
  alias                = "btiq-ingest-db"
  bt_infra_cluster      = "ny2-aze-ntnx-12"
  bt_infra_network      = "ny2-autolab-db-ahv"
  cpus                 = 4
  memory               = 4096
  os_version           = "rhel7"
  foreman_environment  = "nonprod"
  foreman_hostgroup    = "BT Postgresql DB Server"
  datacenter           = "ny2"
   lob                  = "CLOUD"
  additional_disks     = {
    1 = "50",
    2 = "50",
  }
}

output "postgre_btiq" {
  value = {
    "fqdn"  = "${module.postgre_btiq.fqdn}",
    "alias" = "${module.postgre_btiq.alias}",
    "ip"    = "${module.postgre_btiq.ip}",
  }
}