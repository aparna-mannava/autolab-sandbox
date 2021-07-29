terraform {
  backend "s3" {}
}

locals {
    facts       = {
      bt_customer      = "chc"
      bt_product       = "cfrmcloud"
      bt_lob           = "cfrm"
      bt_tier          = "autolab"
      bt_env           = "be"
      bt_env_id        = "01"
      bt_role          = "app"
      bt_infra_cluster    = "ny5-azc-ntnx-16"
      bt_infra_network    = "ny2-autolab-app-ahv"
      hostgroup        = "BT CFRM CLOUD Application Servers"
      firewall_group   = "CFRMRD_PPD_BE"
      environment      = "master"
    }

    cfrmfacts    = {
      ## BE
      ic_hostname1     = "ny2vlcoic1lb${bt_env_id}" ##ny2vlcoic1pd01.saas-p.com
      ic_hostname2     = "ny2vlcoic2lb${bt_env_id}" ##ny2vlcoic2pd01.saas-p.com
      ic_hostname3     = "ny2vlcobt3lb${bt_env_id}" ##ny2vlcobt3pd01.saas-p.com
      be_hostname1     = "ny2vlcoae1lb${bt_env_id}" ##ny2vlcoae1pd01.saas-p.com
      be_hostname2     = "ny2vlcoae2lb${bt_env_id}" ##ny2vlcoae1pd02.saas-p.com
    }
    datacenter = {
      name = "ny2"
      id   = "ny2"
  }
}

module "chc-ic-be-lab01" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = local.cfrmfacts.be_hostname1 
  alias                = "cfrm-cloud-chc-${local.facts.bt_tier}-${local.facts.bt_env_id}-ny2-be01"
  bt_infra_network     = local.facts.bt_infra_network // 
  bt_infra_cluster     = local.facts.bt_infra_cluster
  foreman_environment  = local.facts.environment
  foreman_hostgroup    = local.facts.hostgroup
  firewall_group       = local.facts.firewall_group
  datacenter           = local.datacenter.name
  cpus                 = 8
  memory               = 32000
  os_version           = "rhel7"
  external_facts       = local.cfrmfacts
  additional_disks     = {
    1 = "150"
  }
}

module "chc-ic-be-lab02" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = local.cfrmfacts.be_hostname2
  alias                = "cfrm-cloud-chc-${local.facts.bt_tier}-${local.facts.bt_env_id}-ny2-be02"
  bt_infra_network     = local.facts.bt_infra_network
  bt_infra_cluster     = local.facts.bt_infra_cluster
  foreman_environment  = local.facts.environment
  foreman_hostgroup    = local.facts.hostgroup
  firewall_group       = local.facts.firewall_group   // AE 
  datacenter           = local.datacenter.name
  cpus                 = 8
  memory               = 32000
  os_version           = "rhel7"
  external_facts       = local.cfrmfacts
  additional_disks     = {
    1 = "150"
  }
}

output "chc-ic-be-lab01" {
  value = {
    "fqdn"  = module.chc-ic-be-lab01.fqdn,
    "alias" = module.chc-ic-be-lab01.alias,
    "ip"    = module.chc-ic-be-lab01.ip,
  }
}

output "chc-ic-be-lab02" {
  value = {
    "fqdn"  = module.chc-ic-be-lab02.fqdn,
    "alias" = module.chc-ic-be-lab02.alias,
    "ip"    = module.chc-ic-be-lab02.ip,
  }
}