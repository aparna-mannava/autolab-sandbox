terraform {
  backend "s3" {}
}

locals {
    facts       = {
      bt_customer = "bp"
      bt_product = "cfrmcloud" #  
      bt_lob = "cfrm"
      bt_tier = "autolab"
      bt_env = "ae"
      bt_role = "app"
      bt_infra_cluster = "ny2-aze-ntnx-11"
      bt_infra_network = "ny2-autolab-app-ahv"
      hostgroup = "BT CLOUD CFRM Application Servers"
      #firewall_group  = "CFRMRD_PR_BE"
      environment = "feature_CFRMGC_621_bp_poc_create_vm_servers_on_saas_p"
      hostname = "us01vlbpapp"
    }
    datacenter = {
    name = "ny2"
    id   = "ny2"
  }
}

module "ae_server_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "${local.facts.hostname}-ae1"
  alias                = "${local.facts.bt_product}-${local.facts.bt_customer}-${local.facts.bt_role}-${local.facts.bt_env}01-${local.facts.bt_tier}"
  bt_infra_network     = "${local.facts.bt_infra_network}"
  bt_infra_cluster     = "${local.facts.bt_infra_cluster}"
  foreman_environment  = "${local.facts.environment}"
  foreman_hostgroup    = "${local.facts.hostgroup}"
  #firewall_group       = "${local.facts.firewall_group}"
  datacenter           = "${local.datacenter.name}"
  cpus                 = 4
  memory               = 8096
  os_version           = "rhel7"
  external_facts       = local.facts
  additional_disks     = {
    1 = "150"
  }
}

module "ae_server_2" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "${local.facts.hostname}-ae2"
  alias                = "${local.facts.bt_product}-${local.facts.bt_customer}-${local.facts.bt_role}-${local.facts.bt_env}02-${local.facts.bt_tier}"
  bt_infra_network     = "${local.facts.bt_infra_network}"
  bt_infra_cluster     = "${local.facts.bt_infra_cluster}"
  foreman_environment  = "${local.facts.environment}"
  foreman_hostgroup    = "${local.facts.hostgroup}"
  #firewall_group       = "${local.facts.firewall_group}"
  datacenter           = "${local.datacenter.name}"
  cpus                 = 4
  memory               = 8096
  os_version           = "rhel7"
  external_facts       = local.facts
  additional_disks     = {
    1 = "150"
  }
}

output "ae_server_1" {
  value = {
    "fqdn"  = "${module.ae_server_1.fqdn}",
    "alias" = "${module.ae_server_1.alias}",
    "ip"    = "${module.ae_server_1.ip}",
  }
}

output "ae_server_2" {
  value = {
    "fqdn"  = "${module.ae_server_2.fqdn}",
    "alias" = "${module.ae_server_2.alias}",
    "ip"    = "${module.ae_server_2.ip}",
  }
}