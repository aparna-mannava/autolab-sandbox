terraform {
  backend "http" {}
}
module "postgres_server1" {
  source                = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname              = "us01vltfdemo23"
  alias                 = "tf-pg-mstr63"
  bt_infra_cluster      = "ny2-aze-ntnx-11"
  bt_infra_network      = "ny2-autolab-db-ahv"
  cpus                  = "2"
  memory                = "8192"
  os_version            = "rhel7"
  foreman_environment   = "nonprod"
  foreman_hostgroup     = "BT Postgresql DB Server"
  datacenter            = "ny2"
  lob                   = "CLOUD"
  additional_disks      = {
    1 = "200",
    2 = "320",
    3 = "320",
  }
}
output "postgres_server1" {
  value   = {
    "fqdn"   = "${module.postgres_server1.fqdn}",
	  "alias"  = "${module.postgres_server1.alias}",
    "ip" 	   = "${module.postgres_server1.ip}",
  }
}
module "postgres_server2" {
  source                = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname              = "us01vltfdemo24"
  alias                 = "tf-pg-slv64"
  bt_infra_cluster      = "ny2-aze-ntnx-11"
  bt_infra_network      = "ny2-autolab-db-ahv"
  cpus                  = "2"
  memory                = "8192"
  os_version            = "rhel7"
  foreman_environment   = "nonprod"
  foreman_hostgroup     = "BT Postgresql DB Server"
  datacenter            = "ny2"
  lob                   = "CLOUD"
  additional_disks      = {
    1 = "200",
    2 = "320",
    3 = "320",
  }
}
output "postgres_server2" {
  value   = {
    "fqdn"   = "${module.postgres_server2.fqdn}",
	  "alias"  = "${module.postgres_server2.alias}",
    "ip" 	   = "${module.postgres_server2.ip}",
  }
}
