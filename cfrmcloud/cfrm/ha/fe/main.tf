terraform {
  backend "s3" {}
}

locals {
    facts       = {
      bt_customer       = "chc"
      bt_product        = "cfrmcloud"
      bt_tier           = "autolab"
      env_id            = "01"
      bt_role           = "app"
      bt_infra_cluster  = "ny5-azc-ntnx-16"
      bt_infra_network  = "ny2-autolab-app-ahv"
      hostgroup         = "BT CFRM CLOUD Application Servers"
      firewall_group    = "CFRMRD_PPD_FE"
      environment       = "feature_CFRMCLOUD_1244_cfrm_automated_ha"
    }

    cfrmfacts    = {
      bt_lob           = "cfrm"
      bt_env           = "ic"
      bt_env_id        = local.facts.env_id
      ## IC
      ic_hostname1     = "us01vlcoic1lb${local.facts.env_id}" ##us01vlcoic1pd01.saas-p.com
      ic_hostname2     = "us01vlcoic2lb${local.facts.env_id}" ##us01vlcoic2pd01.saas-p.com
      ic_hostname3     = "us01vlcobt3lb${local.facts.env_id}" ##us01vlcobt3pd01.saas-p.com
      be_hostname1     = "us01vlcoae1lb${local.facts.env_id}" ##us01vlcoae1pd01.saas-p.com
      be_hostname2     = "us01vlcoae2lb${local.facts.env_id}" ##us01vlcoae1pd02.saas-p.com
    }
    datacenter = {
      name = "ny2"
      id   = "ny2"
  }
}

module "chc-ic-fe-lab01" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = local.cfrmfacts.ic_hostname1
  alias                = "cfrm-cloud-chc-${local.facts.bt_tier}-${local.facts.bt_env_id}-ny2-ic01"
  bt_infra_network     = local.facts.bt_infra_network
  bt_infra_cluster     = local.facts.bt_infra_cluster
  foreman_environment  = local.facts.environment
  foreman_hostgroup    = local.facts.hostgroup
  firewall_group       = local.facts.firewall_group// CFRMRD_PR_FE
  datacenter           = local.datacenter.name
  cpus                 = 8
  memory               = 16000
  os_version           = "rhel7"
  external_facts       = local.cfrmfacts
  additional_disks     = {
    1 = "150"
  }
}
module "chc-ic-fe-lab02" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = local.cfrmfacts.ic_hostname2
  alias                = "cfrm-cloud-chc-${local.facts.bt_tier}-${local.facts.bt_env_id}-ny2-ic02"
  bt_infra_network     = local.facts.bt_infra_network
  bt_infra_cluster     = local.facts.bt_infra_cluster
  foreman_environment  = local.facts.environment
  foreman_hostgroup    = local.facts.hostgroup
  firewall_group       = local.facts.firewall_group  //     
  datacenter           = local.datacenter.name
  cpus                 = 8
  memory               = 16000
  os_version           = "rhel7"
  external_facts       = local.cfrmfacts
  additional_disks     = {
    1 = "150"
  }
}
module "chc-ic-fe-lab03" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = local.cfrmfacts.ic_hostname3
  alias                = "cfrm-cloud-chc-${local.facts.bt_tier}-${local.facts.bt_env_id}-ny2-btic03"
  bt_infra_network     = local.facts.bt_infra_network
  bt_infra_cluster     = local.facts.bt_infra_cluster
  foreman_environment  = local.facts.environment
  foreman_hostgroup    = local.facts.hostgroup
  firewall_group       = local.facts.firewall_group//  CFRMRD_PR_FE  
  datacenter           = local.datacenter.name
  cpus                 = 4
  memory               = 8096
  os_version           = "rhel7"
  external_facts       = local.cfrmfacts
  additional_disks     = {
    1 = "150"
  }
}

output "chc-ic-fe-lab01" {
  value = {
    "fqdn"  = module.chc-ic-fe-lab01.fqdn,
    "alias" = module.chc-ic-fe-lab01.alias,
    "ip"    = module.chc-ic-fe-lab01.ip,
  }
}

output "chc-ic-fe-lab02" {
  value = {
    "fqdn"  = module.chc-ic-fe-lab02.fqdn,
    "alias" = module.chc-ic-fe-lab02.alias,
    "ip"    = module.chc-ic-fe-lab02.ip,
  }
}

output "chc-ic-fe-lab03" {
  value = {
    "fqdn"  = module.chc-ic-fe-lab03.fqdn,
    "alias" = module.chc-ic-fe-lab03.alias,
    "ip"    = module.chc-ic-fe-lab03.ip,
  }
}