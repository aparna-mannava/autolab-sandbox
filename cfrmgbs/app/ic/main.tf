terraform {
  backend "s3" {}
}

locals {
    facts       = {
      bt_customer       = ""
      bt_product        = "cfrmcloud"
      bt_lob            = "cfrm"
      bt_tier           = "autolab"
      bt_env            = "ic"
      bt_role           = "app"
      bt_infra_cluster = "ny2-aze-ntnx-11"
      bt_infra_network = "ny2-autolab-app-ahv"
      hostgroup         = "BT CFRM CLOUD Application Servers"
      #firewall_group    = "CFRMRD_PR_FE"
      environment       = "master"
      hostname          = "us01vlcfic"
    }
    datacenter = {
      name = "ny2"
      id   = "ny2"
  }
}

module "ic_server_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "${local.facts.hostname}01-al" // gb00vlcfic01-ut.saas-p.com
  alias                = "${local.facts.bt_product}-${local.facts.bt_tier}-${local.datacenter.id}-${local.facts.bt_env}01"// cfrmcloud-uat-gb00-ic01
  bt_infra_network     = "${local.facts.bt_infra_network}"
  bt_infra_cluster     = "${local.facts.bt_infra_cluster}"
  foreman_environment  = "${local.facts.environment}"
  foreman_hostgroup    = "${local.facts.hostgroup}"
  #firewall_group       = "${local.facts.firewall_group}"// CFRMRD_PR_FE
  datacenter           = "${local.datacenter.name}"
  cpus                 = 2
  memory               = 4096
  os_version           = "rhel7"
  external_facts       = local.facts
  additional_disks     = {
    1 = "150"
  }
}

module "ic_server_2" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "${local.facts.hostname}02-al" //gb00vlcfic02-ut.saas-p.com
  alias                = "${local.facts.bt_product}-${local.facts.bt_tier}-${local.datacenter.id}-${local.facts.bt_env}02" // cfrmcloud-uat-gb00-ae02
  bt_infra_network     = "${local.facts.bt_infra_network}"
  bt_infra_cluster     = "${local.facts.bt_infra_cluster}"
  foreman_environment  = "${local.facts.environment}"
  foreman_hostgroup    = "${local.facts.hostgroup}"
  #firewall_group       = "${local.facts.firewall_group}" // CFRMRD_PR_FE
  datacenter           = "${local.datacenter.name}"
  cpus                 = 2
  memory               = 4096
  os_version           = "rhel7"
  external_facts       = local.facts
  additional_disks     = {
    1 = "150"
  }
}

output "ic_server_1" {
  value = {
    "fqdn"  = "${module.ic_server_1.fqdn}",
    "alias" = "${module.ic_server_1.alias}",
    "ip"    = "${module.ic_server_1.ip}",
  }
}

output "ic_server_2" {
  value = {
    "fqdn"  = "${module.ic_server_2.fqdn}",
    "alias" = "${module.ic_server_2.alias}",
    "ip"    = "${module.ic_server_2.ip}",
  }
}