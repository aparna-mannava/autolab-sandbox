terraform {
  backend "s3" {}
}

locals {
  facts       = {
    "bt_product" = "inf"
  }
}

module "puppet_server_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlpups01"
  bt_infra_cluster     = "ny2-aza-vmw-autolab"
  bt_infra_network     = "ny2-autolab-app"
  lob                  = "INF"
  cpus                 = "2"
  memory               = "4096"
  external_facts       = local.facts
  os_version           = "rhel7"
  foreman_environment  = "master"
  foreman_hostgroup    = "BT Base Server"
  datacenter           = "ny2"
  additional_disks     = {
    1 = "100",
  }
}

module "puppet_agent_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlpupa01"
  bt_infra_cluster     = "ny2-aza-vmw-autolab"
  bt_infra_network     = "ny2-autolab-app"
  lob                  = "INF"
  cpus                 = "2"
  memory               = "4096"
  external_facts       = local.facts
  os_version           = "rhel7"
  foreman_environment  = "master"
  foreman_hostgroup    = "BT Base Server"
  datacenter           = "ny2"
  additional_disks     = {
    1 = "100",
  }
}

module "vault_server_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlvls01"
  bt_infra_cluster     = "ny2-aza-vmw-autolab"
  bt_infra_network     = "ny2-autolab-app"
  lob                  = "INF"
  cpus                 = "2"
  memory               = "4096"
  external_facts       = local.facts
  os_version           = "rhel7"
  foreman_environment  = "master"
  foreman_hostgroup    = "BT Base Server"
  datacenter           = "ny2"
  additional_disks     = {
    1 = "100",
  }
}

output "puppet_server_1" {
  value = {
    "fqdn"  = "${module.puppet_server_1.fqdn}",
    "alias" = "${module.puppet_server_1.alias}",
    "ip"    = "${module.puppet_server_1.ip}",
  }
}

output "puppet_agent_1" {
  value = {
    "fqdn"  = "${module.puppet_agent_1.fqdn}",
    "alias" = "${module.puppet_agent_1.alias}",
    "ip"    = "${module.puppet_agent_1.ip}",
  }
}

output "vault_server_1" {
  value = {
    "fqdn"  = "${module.vault_server_1.fqdn}",
    "alias" = "${module.vault_server_1.alias}",
    "ip"    = "${module.vault_server_1.ip}",
  }
}
