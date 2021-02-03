terraform {
  backend "s3" {}
}
locals {
  facts       = {
    "bt_tier"       = "dev"
    "bt_product"    = "fmcloud"
    "bt_role"       = "postgresql"
    "bt_env"        = "1"
    "bt_pg_version" = "12"
  }
}

resource "null_resource" "staging_for_delete" {}

module "postgres_server1" {
  source                = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname              = "us01vltfdm069"
  alias                 = "tf-pg-mstr069"
  bt_infra_cluster      = "ny2-azb-ntnx-09"
  bt_infra_network      = "ny2-autolab-app-ahv"
  cpus                  = "2"
  memory                = "4098"
  os_version            = "rhel7"
  foreman_environment   = "feature_CLOUD_81808"
  foreman_hostgroup     = "BT Postgresql DB Server"
  external_facts        = "${local.facts}"
  datacenter            = "ny2"
  lob                   = "CLOUD"
  additional_disks      = {
    1 = "100",
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
