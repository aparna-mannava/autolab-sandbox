terraform {
  backend "http" {}
}

locals {
  lob           = "dgb"
  puppet_env    = "master"
  datacenter    = "ny2"
  facts         = {
    "bt_customer"         = "fi9808"
    "bt_tier"             = "demo"
    "bt_env"              = "1"
    "bt_product"          = "dgb"
    "bt_product_version"  = "3.6"
  }
}

module "db_server_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vltfdb27"
  os_version           = "rhel7"
  alias                = "${local.lob}-tf-${local.facts.bt_tier}${local.facts.bt_env}-${local.facts.bt_customer}-db01"
  datacenter           = local.datacenter
  bt_infra_network     = "ny2-autolab-app-ahv"
  bt_infra_cluster     = "ny2-aza-ntnx-05"
  foreman_environment  = local.puppet_env
  foreman_hostgroup    = "BT DGB Oradb Server"
  lob                  = "CLOUD"
  external_facts       = local.facts
  cpus                 = "4"
  memory               = "8192"
  additional_disks     = {
    1 = "200",
    2 = "200",
    3 = "200"
  }
}

module "db_server_2" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vltfdb28"
  os_version           = "rhel7"
  alias                = "${local.lob}-tf-${local.facts.bt_tier}${local.facts.bt_env}-${local.facts.bt_customer}-db02"
  datacenter           = local.datacenter
  bt_infra_network     = "ny2-autolab-app-ahv"
  bt_infra_cluster     = "ny2-aza-ntnx-05"
  foreman_environment  = local.puppet_env
  foreman_hostgroup    = "BT DGB Oradb Secondary Server"
  lob                  = "CLOUD"
  external_facts       = local.facts
  cpus                 = "4"
  memory               = "8192"
  additional_disks     = {
    1 = "200",
    2 = "200",
    3 = "200"
  }
}

module "db_server_3" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vltfdb30"
  os_version           = "rhel7"
  alias                = "${local.lob}-tf-${local.facts.bt_tier}${local.facts.bt_env}-${local.facts.bt_customer}-db03"
  datacenter           = local.datacenter
  bt_infra_network     = "ny2-autolab-app-ahv"
  bt_infra_cluster     = "ny2-aza-ntnx-05"
  foreman_environment  = local.puppet_env
  foreman_hostgroup    = "BT DGB Oradb Secondary Server"
  lob                  = "CLOUD"
  external_facts       = local.facts
  cpus                 = "4"
  memory               = "8192"
  additional_disks     = {
    1 = "200",
    2 = "200",
    3 = "200"
  }
}

module "db_observer_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vltfob29" #ex: us01vldgbdbXXX
  os_version           = "rhel7"
  alias                = "${local.lob}-tf-${local.facts.bt_tier}${local.facts.bt_env}-${local.facts.bt_customer}-ob01"
  datacenter           = local.datacenter
  bt_infra_network     = "ny2-autolab-app-ahv"
  bt_infra_cluster     = "ny2-aza-ntnx-05"
  foreman_environment  = local.puppet_env
  foreman_hostgroup    = "BT DGB Oradb fsfo Observer"
  lob                  = "CLOUD"
  external_facts       = local.facts
  cpus                 = "2"
  memory               = "4096"
  additional_disks     = {
    1 = "200"
  }
}

module "db_observer_2" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vltfob31" #ex: us01vldgbdbXXX
  os_version           = "rhel7"
  alias                = "${local.lob}-tf-${local.facts.bt_tier}${local.facts.bt_env}-${local.facts.bt_customer}-ob02"
  datacenter           = local.datacenter
  bt_infra_network     = "ny2-autolab-app-ahv"
  bt_infra_cluster     = "ny2-aza-ntnx-05"
  foreman_environment  = local.puppet_env
  foreman_hostgroup    = "BT DGB Oradb fsfo Observer"
  lob                  = "CLOUD"
  external_facts       = local.facts
  cpus                 = "2"
  memory               = "4096"
  additional_disks     = {
    1 = "200"
  }
}

output "db_server_1" {
  value = {
    "fqdn"  = "${module.db_server_1.fqdn}",
    "alias" = "${module.db_server_1.alias}",
    "ip"    = "${module.db_server_1.ip}",
  }
}

output "db_server_2" {
  value = {
    "fqdn"  = "${module.db_server_2.fqdn}",
    "alias" = "${module.db_server_2.alias}",
    "ip"    = "${module.db_server_2.ip}",
  }
}

output "db_server_3" {
  value = {
    "fqdn"  = "${module.db_server_3.fqdn}",
    "alias" = "${module.db_server_3.alias}",
    "ip"    = "${module.db_server_3.ip}",
  }
}

output "db_observer_1" {
  value = {
    "fqdn"  = "${module.db_observer_1.fqdn}",
    "alias" = "${module.db_observer_1.alias}",
    "ip"    = "${module.db_observer_1.ip}",
  }
}

output "db_observer_2" {
  value = {
    "fqdn"  = "${module.db_observer_2.fqdn}",
    "alias" = "${module.db_observer_2.alias}",
    "ip"    = "${module.db_observer_2.ip}",
  }
}
