terraform {
  backend "http" {}
}

locals {
  facts       = {
    "bt_tier"    = "dev"
    "bt_product" = "btiq"
    "bt_role" = "mysql"
    "bt_env"    = "1"
  }
}

module "mysql-service" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlbtiqmysql01"
  alias                = "btiq_ovalegde_mysql_auto_01"
  bt_infra_cluster     = "ny2-azd-ntnx-10"
  bt_infra_network     = "ny2-autolab-app-ahv"
  os_version           = "rhel7"
  foreman_environment  = "feature_CLOUD_69165"
  foreman_hostgroup    = "BT BTIQ MYSQL Server"
  datacenter           = "ny2"
  lob                  = "dev"
  cpus                 = "2"
  memory               = "4098"
  additional_disks     = {
    1 = "100"
    2 = "100"
    3 = "100"
  }
  external_facts       = local.facts
}

output "mysql-service" {
  value = {
    "fqdn"  = "${module.mysql-service.fqdn}",
    "alias" = "${module.mysql-service.alias}",
    "ip"    = "${module.mysql-service.ip}",
  }

}
