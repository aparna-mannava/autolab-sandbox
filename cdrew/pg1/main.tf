terraform {
  backend "s3" {}
}

module "postgres_server1" {
  source                = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname              = "us01vlcrd1"
  alias                 = "crd-pg-db01"
  cluster               = "ny5-azc-ntnx-16"
  network               = "ny2-autolab-app-ahv"
  cpus                  = "2"
  memory                = "8192"
  os_version            = "rhel8"
  bt_env                = "1"
  bt_product            = "btiq"
  environment           = "master"
  hostgroup             = "BT Postgresql DB Server"
  datacenter            = "ny2"
  lob                   = "CEA"
  additional_disks      = {
    1 = "50",
    2 = "50",
  }
}

output "postgres_server1" {
  value   = {
    "fqdn"   = "${module.postgres_server1.fqdn}",
	  "alias"  = "${module.postgres_server1.alias}",
    "ip" 	   = "${module.postgres_server1.ip}",
  }
}
