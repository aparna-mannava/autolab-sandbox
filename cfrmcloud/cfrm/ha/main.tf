terraform {
  backend "s3" {}
}

locals {
   facts       = {
      customer         = "chc"
      product          = "cfrmcloud"
      tier             = "autolab"
      env_id           = "01"
      bt_role          = "app"
      cfrm_version     = "5901_SP2" // Mandatory
      bt_infra_cluster = "ny5-azc-ntnx-16"
      bt_infra_network = "ny2-autolab-app-ahv"
      hostgroup        = "BT CFRM CLOUD Application Servers"
      firewall_group   = "CFRMRD_PPD_BE"
      environment      = "feature_CFRMCLOUD_1244_cfrm_automated_ha"
      ic_host1         = "us01vlcoic1lb${local.facts.env_id}" ##us01vlcoic1pd01.saas-p.com
      ic_host2         = "us01vlcoic2lb${local.facts.env_id}" ##us01vlcoic2pd01.saas-p.com  //
      ic_host3         = "us01vlcobt3lb${local.facts.env_id}" ##us01vlcobt3pd01.saas-p.com
      be_host1         = "us01vlcoae1lb${local.facts.env_id}" ##us01vlcoae1pd01.saas-p.com
      be_host2         = "us01vlcoae2lb${local.facts.env_id}" ##us01vlcoae1pd02.saas-p.com
    }
    ## IC-FE
    cfrmfacts_ic    = {
      bt_customer      = local.facts.customer
      bt_product       = local.facts.product
      bt_tier          = local.facts.tier
      bt_lob           = "cfrm"
      bt_env           = "ic"
      bt_env_id        = local.facts.env_id
      bt_ic_version    = local.facts.cfrm_version
      ic_hostname1     = local.facts.ic_host1
      ic_hostname2     = local.facts.ic_host2
      ic_hostname3     = local.facts.ic_host3
      be_hostname1     = local.facts.be_host1
      be_hostname2     = local.facts.be_host2
    }
    ## AE-BE 
    cfrmfacts_be    = {
      bt_customer      = local.facts.customer
      bt_product       = local.facts.product
      bt_tier          = local.facts.tier
      bt_lob           = "cfrm"
      bt_env           = "be"
      bt_env_id        = local.facts.env_id
      bt_ic_version    = local.facts.cfrm_version
      ic_hostname1     = local.facts.ic_host1
      ic_hostname2     = local.facts.ic_host2
      ic_hostname3     = local.facts.ic_host3
      be_hostname1     = local.facts.be_host1
      be_hostname2     = local.facts.be_host2
    }
  }
    datacenter = {
      name = "ny2"
      id   = "ny2"
  }
}

module "chc-ic-be-lab01" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = local.facts.cfrmfacts_be.be_hostname1 
  alias                = "cfrm-cloud-chc-${local.facts.cfrmfacts_be.bt_tier}-${local.facts.env_id}-${datacenter.id}-be01"
  bt_infra_network     = local.facts.bt_infra_network // 
  bt_infra_cluster     = local.facts.bt_infra_cluster
  foreman_environment  = local.facts.environment
  foreman_hostgroup    = local.facts.hostgroup
  lob                  = "cfrm"
  #firewall_group       = local.facts.firewall_group
  datacenter           = local.datacenter.name
  cpus                 = 8
  memory               = 32000
  os_version           = "rhel7"
  external_facts       = local.facts.cfrmfacts_be
  additional_disks     = {
    1 = "150"
  }
}

module "chc-ic-be-lab02" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = local.facts.cfrmfacts_be.be_hostname2
  alias                = "cfrm-cloud-chc-${local.facts.cfrmfacts_be.bt_tier}-${local.facts.env_id}-${datacenter.id}-be02"
  bt_infra_network     = local.facts.bt_infra_network
  bt_infra_cluster     = local.facts.bt_infra_cluster
  foreman_environment  = local.facts.environment
  foreman_hostgroup    = local.facts.hostgroup
  lob                  = "cfrm"
  #firewall_group       = local.facts.firewall_group   // AE 
  datacenter           = local.datacenter.name
  cpus                 = 8
  memory               = 32000
  os_version           = "rhel7"
  external_facts       = local.facts.cfrmfacts_be
  additional_disks     = {
    1 = "150"
  }
}

module "chc-ic-fe-lab01" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = local.facts.cfrmfacts_ic.ic_hostname1
  alias                = "cfrm-cloud-chc-${local.facts.cfrmfacts_ic.bt_tier}-${local.facts.env_id}-${datacenter.id}-ic01"
  bt_infra_network     = local.facts.bt_infra_network
  bt_infra_cluster     = local.facts.bt_infra_cluster
  foreman_environment  = local.facts.environment
  foreman_hostgroup    = local.facts.hostgroup
  lob                  = "cfrm"
  #firewall_group       = local.facts.firewall_group// CFRMRD_PR_FE
  datacenter           = local.datacenter.name
  cpus                 = 8
  memory               = 16000
  os_version           = "rhel7"
  external_facts       = local.facts.cfrmfacts_ic
  additional_disks     = {
    1 = "150"
  }
}
module "chc-ic-fe-lab02" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = local.facts.cfrmfacts_ic.ic_hostname2
  alias                = "cfrm-cloud-chc-${local.facts.cfrmfacts_ic.bt_tier}-${local.facts.env_id}-${datacenter.id}-ic02"
  bt_infra_network     = local.facts.bt_infra_network
  bt_infra_cluster     = local.facts.bt_infra_cluster
  foreman_environment  = local.facts.environment
  foreman_hostgroup    = local.facts.hostgroup
  lob                  = "cfrm"
  #firewall_group       = local.facts.firewall_group  //     
  datacenter           = local.datacenter.name
  cpus                 = 8
  memory               = 16000
  os_version           = "rhel7"
  external_facts       = local.facts.cfrmfacts_ic
  additional_disks     = {
    1 = "150"
  }
}
module "chc-ic-fe-lab03" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = local.facts.cfrmfacts_ic.ic_hostname3
  alias                = "cfrm-cloud-chc-${local.facts.cfrmfacts_ic.bt_tier}-${local.facts.env_id}-${datacenter.id}-btic01"
  bt_infra_network     = local.facts.bt_infra_network
  bt_infra_cluster     = local.facts.bt_infra_cluster
  foreman_environment  = local.facts.environment
  foreman_hostgroup    = local.facts.hostgroup
  lob                  = "cfrm"
  #firewall_group       = local.facts.firewall_group//  CFRMRD_PR_FE  
  datacenter           = local.datacenter.name
  cpus                 = 4
  memory               = 8096
  os_version           = "rhel7"
  external_facts       = local.facts.cfrmfacts_ic
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