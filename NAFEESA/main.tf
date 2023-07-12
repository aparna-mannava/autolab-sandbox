terraform {
  backend "s3" {}
}

locals {
  lob           = "CLOUD"
  puppet_env    = "master"
  datacenter    = "ny2"
  domain        = "auto.saas-n.com"
  facts         = {
   

    "bt_product"      = "cloud"
    "bt_role"         = "oradb"
    "bt_tier"         = "tst"
    "bt_env"              = "" ##ex: leave blank for first env, or non-zero-padded number
    "bt_product_version"  = "3.6"
    "bt_em_agent"         = "13.4.0.0"
  }

  db_hostname            = "us01vldgbts20" #ex: us01vldgbdbXXX
  db_alias               = "Oracle-test-server"
  db_bt_infra_network    = "ny2-autolab-app-ahv"
  db_bt_infra_cluster    = "ny5-azh-ntnx-26"
  db_foreman_hostgroup   = "BT DGB Generic Server" # BT DGB Generic Server,BT DGB Oradb Server
}

module "db_server" {
  source               = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  hostname             = local.db_hostname
  os_version           = "rhel8"
  lob                  = local.lob
  alias                = local.db_alias
  datacenter           = local.datacenter
  bt_infra_network     = local.db_bt_infra_network
  bt_infra_cluster     = local.db_bt_infra_cluster
  foreman_environment  = local.puppet_env
  foreman_hostgroup    = local.db_foreman_hostgroup
  external_facts       = local.facts
  cpus                 = "4"
  memory               = "16384"
  additional_disks     = {
    1 = "200",
    2 = "250",
    3 = "250"
  }
}

output "host_file" {
  value = <<HOSTFILE

${module.db_server.ip}  db
  HOSTFILE
}

output "db_server" {
  value = {
    "fqdn"  = module.db_server.fqdn,
    "alias" = module.db_server.alias,
    "ip"    = module.db_server.ip,
  }
}
