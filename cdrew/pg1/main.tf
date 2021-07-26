terraform {
  backend "s3" {}
}

locals {
  facts       = {
    "bt_pg_version" = "12"
    }
}


module "postgres_server1" {
  source                = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname              = "us01vlcrd1"
  alias                 = "crd-pg-db02"
  bt_infra_cluster      = "ny5-azc-ntnx-16"
  bt_infra_network      = "ny2-autolab-app-ahv"
  cpus                  = "2"
  memory                = "8192"
  os_version            = "rhel8"
  foreman_environment   = "master"
  foreman_hostgroup     = "BT Postgresql DB Server"
  datacenter            = "ny2"
  lob                   = "CEA"
  external_facts        = local.facts
  additional_disks      = {
    1 = "50",
    2 = "60",
  }
}

output "postgres_server1" {
  value   = {
    "fqdn"   = "${module.postgres_server1.fqdn}",
	  "alias"  = "${module.postgres_server1.alias}",
    "ip" 	   = "${module.postgres_server1.ip}",
  }
}
