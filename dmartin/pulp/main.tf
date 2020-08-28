terraform {
  backend "http" {}
}

locals {
  facts       = {
    "bt_product" = "cea"
  }
}

module "pulp" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlpulp9999"
  bt_infra_cluster     = "ny2-aza-vmw-autolab"
  bt_infra_network     = "ny2-autolab-app"
  lob                  = "CEA"
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

output "pulp" {
  value = {
    "fqdn"  = "${module.pulp.fqdn}",
    "alias" = "${module.pulp.alias}",
    "ip"    = "${module.pulp.ip}",
  }
}

