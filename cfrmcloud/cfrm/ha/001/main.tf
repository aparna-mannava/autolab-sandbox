terraform {
  backend "s3" {}
}

locals {
   env_id              = "01"
   facts     = {
      customer         = "chc"
      product          = "cfrmcloud"
      tier             = "autolab"
      env_id           = "01"
      bt_role          = "app"
      bt_lob           = "CFRM"
      cfrm_version     = "5901_SP4" // Mandatory
      bt_infra_cluster = "ny5-azc-ntnx-16"
      bt_infra_network = "ny2-autolab-app-ahv"
      hostgroup        = "BT CFRM CLOUD Application Servers"
      firewall_group   = "CFRMRD_PPD_BE"
      environment      = "feature_CFRMCLOUD_1244_cfrm_automated_ha"
      ### App ###
      ic_host1         = "us01vl${local.env_id}coicau1" ##us01vl01coicpd1.saas-p.com
      ic_host2         = "us01vl${local.env_id}coicau2" ##us01vl01coicpd2.saas-p.com    
      ic_host3         = "us01vl${local.env_id}cobtau3" ##us01vl01cobtpd3.saas-p.com // ONLY for C.Hoare  
      be_host1         = "us01vl${local.env_id}coaeau1" ##us01vl01coaepd1.saas-p.com
      be_host2         = "us01vl${local.env_id}coaeau2" ##us01vl01coaepd2.saas-p.com
      ### ELK ###
      elk_host1       = "us01vlcoel01-au.auto.saas-n.com"
      elk_host2       = "us01vlcoel02-au.auto.saas-n.com"
      elk_host3       = "us01vlcoel03-au.auto.saas-n.com"    
    }
    
    ### DB ###
      cfrm_db = {
          db_host         = "us01vlcfdblab01.auto.saas-n.com"
          db_sid          = "CFRMAU01"
          db_port         = "1560"
          db_re_usr       = "CHC_RE_LAB_${local.env_id}"
          db_cld_usr      = "CHC_CLD_LAB_${local.env_id}"
          db_stg_usr      = "CHC_STG_LAB_${local.env_id}"
          db_jobs_usr     = "CHC_JB_LAB_${local.env_id}"
      }

    ## IC-FE
    cfrmfacts_ic    = {
      bt_customer      = local.facts.customer
      bt_product       = local.facts.product
      bt_tier          = local.facts.tier
      bt_lob           = "CFRM"
      bt_env           = "ic"
      bt_env_id        = local.env_id
      bt_ic_version    = local.facts.cfrm_version
      ic_hostname1     = local.facts.ic_host1
      ic_hostname2     = local.facts.ic_host2
      ic_hostname3     = local.facts.ic_host3
      be_hostname1     = local.facts.be_host1
      be_hostname2     = local.facts.be_host2
      bt_cfrm_db       = local.cfrm_db
      # bt_db_host       = local.facts.db_host
      # bt_db_sid        = local.facts.db_sid
      # bt_db_re_usr     = local.facts.db_re_usr
      # bt_db_cld_usr    = local.facts.db_cld_usr
      # bt_db_stg_usr    = local.facts.db_stg_usr
      # bt_db_jobs_usr   = local.facts.db_jobs_usr
    }
    ## AE-BE 
    cfrmfacts_be    = {
      bt_customer      = local.facts.customer
      bt_product       = local.facts.product
      bt_tier          = local.facts.tier
      bt_lob           = "CFRM"
      bt_env           = "be"
      bt_env_id        = local.env_id
      bt_ic_version    = local.facts.cfrm_version
      ic_hostname1     = local.facts.ic_host1
      ic_hostname2     = local.facts.ic_host2
      ic_hostname3     = local.facts.ic_host3
      be_hostname1     = local.facts.be_host1
      be_hostname2     = local.facts.be_host2
      bt_cfrm_db       = local.cfrm_db
    }
  
    datacenter = {
      name = "ny2"
      id   = "ny2"
  }
}

module "chc-ic-be-lab01" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = local.facts.be_host1
  alias                = "cfrm-cloud-chc-${local.facts.tier}-${local.env_id}-${local.datacenter.name}-be01"
  bt_infra_network     = local.facts.bt_infra_network   // 
  bt_infra_cluster     = local.facts.bt_infra_cluster
  foreman_environment  = local.facts.environment
  foreman_hostgroup    = local.facts.hostgroup
  lob                  = "CFRM"
  #firewall_group       = local.facts.firewall_group
  datacenter           = local.datacenter.name
  cpus                 = 8
  memory               = 32000
  os_version           = "rhel7"
  external_facts       = local.cfrmfacts_be
  additional_disks     = {
    1 = "150"
  }
}

module "chc-ic-be-lab02" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = local.facts.be_host2
  alias                = "cfrm-cloud-chc-${local.facts.tier}-${local.env_id}-${local.datacenter.name}-be02"
  bt_infra_network     = local.facts.bt_infra_network
  bt_infra_cluster     = local.facts.bt_infra_cluster
  foreman_environment  = local.facts.environment
  foreman_hostgroup    = local.facts.hostgroup
  lob                  = "CFRM"
  #firewall_group       = local.facts.firewall_group   // AE 
  datacenter           = local.datacenter.name
  cpus                 = 8
  memory               = 32000
  os_version           = "rhel7"
  external_facts       = local.cfrmfacts_be
  additional_disks     = {
    1 = "150"
  }
}

module "chc-ic-fe-lab01" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = local.facts.ic_host1
  alias                = "cfrm-cloud-chc-${local.facts.tier}-${local.env_id}-${local.datacenter.name}-ic01"
  bt_infra_network     = local.facts.bt_infra_network
  bt_infra_cluster     = local.facts.bt_infra_cluster
  foreman_environment  = local.facts.environment
  foreman_hostgroup    = local.facts.hostgroup
  lob                  = "CFRM"
  #firewall_group       = local.facts.firewall_group// CFRMRD_PR_FE
  datacenter           = local.datacenter.name
  cpus                 = 8
  memory               = 16000
  os_version           = "rhel7"
  external_facts       = local.cfrmfacts_ic
  additional_disks     = {
    1 = "150"
  }
}
module "chc-ic-fe-lab02" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = local.facts.ic_host2
  alias                = "cfrm-cloud-chc-${local.facts.tier}-${local.env_id}-${local.datacenter.name}-ic02"
  bt_infra_network     = local.facts.bt_infra_network
  bt_infra_cluster     = local.facts.bt_infra_cluster
  foreman_environment  = local.facts.environment
  foreman_hostgroup    = local.facts.hostgroup
  lob                  = "CFRM"
  #firewall_group       = local.facts.firewall_group  // 
  datacenter           = local.datacenter.name
  cpus                 = 8
  memory               = 16000
  os_version           = "rhel7"
  external_facts       = local.cfrmfacts_ic
  additional_disks     = {
    1 = "150"
  }
}
module "chc-ic-fe-lab03" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = local.facts.ic_host3
  alias                = "cfrm-cloud-chc-${local.facts.tier}-${local.env_id}-${local.datacenter.name}-btic01"
  bt_infra_network     = local.facts.bt_infra_network
  bt_infra_cluster     = local.facts.bt_infra_cluster
  foreman_environment  = local.facts.environment
  foreman_hostgroup    = local.facts.hostgroup
  lob                  = "CFRM"
  #firewall_group       = local.facts.firewall_group//  CFRMRD_PR_FE  
  datacenter           = local.datacenter.name
  cpus                 = 4
  memory               = 8096
  os_version           = "rhel7"
  external_facts       = local.cfrmfacts_ic
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