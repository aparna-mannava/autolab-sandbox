terraform {
  backend "s3" {}
}

locals {
  facts       = {
    "bt_tier" = "dev"
    "bt_env"  = "9"
    "bt_product" = "inf"
  }
}

module "db_server1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlss01"
  alias                = "bt-${local.facts.bt_tier}${local.facts.bt_env}-ss01"
  bt_infra_network     = "ny2-autolab-app"
  bt_infra_cluster     = "ny2-aza-vmw-autolab"
  cpus                 = 2
  memory               = 33696
  os_version           = "rhel8"
  external_facts       = local.facts
  lob       	         = "DGB"
  foreman_environment  = "master"
  foreman_hostgroup    = "BT Streamsets Server"
  datacenter           = "ny2"
  additional_disks     = {
    1 = "100",
    2 = "250",
  }
}

module "db_server2" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlss02"
  alias                = "bt-${local.facts.bt_tier}${local.facts.bt_env}-ss02"
  bt_infra_network     = "ny2-autolab-app"
  bt_infra_cluster     = "ny2-aza-vmw-autolab"
  cpus                 = 2
  memory               = 33696
  os_version           = "rhel8"
  external_facts       = local.facts
  lob       	         = "DGB"
  foreman_environment  = "master"
  foreman_hostgroup    = "BT Streamsets Server"
  datacenter           = "ny2"
  additional_disks     = {
    1 = "100",
    2 = "250",
  }
}

output "ss_server1" {
  value = {
    "fqdn"  = module.db_server1.fqdn,
    "alias" = module.db_server1.alias,
    "ip"    = module.db_server1.ip,
  }
}

output "ss_server2" {
  value = {
    "fqdn"  = module.db_server2.fqdn,
    "alias" = module.db_server2.alias,
    "ip"    = module.db_server2.ip,
  }
}
