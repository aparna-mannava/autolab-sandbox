## !!!!!!!!!!
## This Terraform project must be upgraded before it can be modified.
## Please refer to https://confluence.bottomline.tech/display/CEA/Terraform+upgrade+guide for instructions.
## Once the upgrade is done, please remove this comment block.
## !!!!!!!!!!

terraform {
  backend "s3" {}
}

locals {
  lob           = "cloud"
  puppet_env    = "feature_testing-fsfo"
  datacenter    = "ny2"
  facts         = {
    "bt_customer"         = "fi9999" #ex: fiXXXX
    "bt_tier"             = "dev" #ex: sbx, tst, td, demo
    "bt_env"              = "" #ex: leave blank for first env, or non-zero-padded number
    "bt_product"          = "dgb"
    "bt_product_version"  = "3.6"
  }
}

module "db_server_autolab_pci_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vldgbdb500" #ex: us01vldgbdbXXX
  os_version           = "rhel7"
  alias                = "${local.lob}-pci-${local.facts.bt_tier}${local.facts.bt_env}-${local.facts.bt_customer}-oradb01"
  datacenter           = local.datacenter
  bt_infra_network     = "ny2-autolab-app-ahv"
  bt_infra_cluster     = "ny5-azc-ntnx-16"
  foreman_environment  = local.puppet_env
  foreman_hostgroup    = "BT DGB Oradb Server" #"BT DGB Oradb Server"
  external_facts       = local.facts
  cpus                 = "2"
  memory               = "4096"
  additional_disks     = {
    1 = "50",
    2 = "50",
    3 = "50"
  }
}

module "db_server_autolab_pci_2" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vldgbdb501" #ex: us01vldgbdbXXX
  os_version           = "rhel7"
  alias                = "${local.lob}-pci-${local.facts.bt_tier}${local.facts.bt_env}-${local.facts.bt_customer}-oradb02"
  datacenter           = local.datacenter
  bt_infra_network     = "ny2-autolab-app-ahv"
  bt_infra_cluster     = "ny5-azc-ntnx-16"
  foreman_environment  = local.puppet_env
  foreman_hostgroup    = "BT DGB Oradb Secondary Server" #"BT DGB Oradb Secondary Server"
  external_facts       = local.facts
  cpus                 = "2"
  memory               = "4096"
  additional_disks     = {
    1 = "50",
    2 = "50",
    3 = "50"
  }
}

module "db_observer_autolab_pci_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vldgbdb502" #ex: us01vldgbdbXXX
  os_version           = "rhel7"
  alias                = "${local.lob}-pci-${local.facts.bt_tier}${local.facts.bt_env}-${local.facts.bt_customer}-oraob01"
  datacenter           = local.datacenter
  bt_infra_network     = "ny2-autolab-app-ahv"
  bt_infra_cluster     = "ny5-azc-ntnx-16"
  foreman_environment  = local.puppet_env
  foreman_hostgroup    = "BT DGB Oradb fsfo Observer" #"BT DGB Oradb fsfo Observer"
  external_facts       = local.facts
  cpus                 = "2"
  memory               = "4096"
  additional_disks     = {
    1 = "50"
  }
}

output "db_server_autolab_pci_1" {
  value = {
    "fqdn"  = "${module.db_server_autolab_pci_1.fqdn}",
    "alias" = "${module.db_server_autolab_pci_1.alias}",
    "ip"    = "${module.db_server_autolab_pci_1.ip}",
  }
}

output "db_server_autolab_pci_2" {
  value = {
    "fqdn"  = "${module.db_server_autolab_pci_2.fqdn}",
    "alias" = "${module.db_server_autolab_pci_2.alias}",
    "ip"    = "${module.db_server_autolab_pci_2.ip}",
  }
}

output "db_observer_autolab_pci_1" {
  value = {
    "fqdn"  = "${module.db_observer_autolab_pci_1.fqdn}",
    "alias" = "${module.db_observer_autolab_pci_1.alias}",
    "ip"    = "${module.db_observer_autolab_pci_1.ip}",
  }
}
