terraform {
  backend "s3" {}
}

locals {
   env_id              = "02"
   facts     = {
      customer         = "fml" // pre customer
      product          = "cfrmcloud"
      tier             = "autolab" //changed on each env 
      role             = "app"
      bt_lob           = "CFRM"
      cfrm_version     = "640_SP2" // Mandatory rebuild
      bt_infra_cluster = "ny5-azc-ntnx-16"
      bt_infra_network = "ny2-autolab-app-ahv"
      hostgroup        = "BT CFRM CLOUD Application Servers"
      firewall_group   = "CFRMRD_PPD_BE"
      environment      = "CFRMCLOUD_405_fml_saas_p_gb00_uat_servers_instantiation"
    }
    
    ### App ###
    cfrm_hosts = {
          ic_host1         = "us01vl${local.env_id}cfrmic1" ##us01vl01coicpd1.saas-p.com
          ic_host2         = "us01vl${local.env_id}cfrmic2" ##us01vl01coicpd2.saas-p.com    
          be_host1         = "us01vl${local.env_id}cfrmae1" ##us01vl01coaepd1.saas-p.com
          be_host2         = "us01vl${local.env_id}cfrmae2" ##us01vl01coaepd2.saas-p.com
    }

    ### ELK ###
    cfrm_elk = {
          elk_host1       = "us01vlcfel01-au.auto.saas-n.com"
          elk_host2       = "us01vlcfel02-au.auto.saas-n.com"
          elk_host3       = "us01vlcfel03-au.auto.saas-n.com"
      }    
    
    ### DB ###
    cfrm_db = {
          db_host         = "us01vlcfdblab01.auto.saas-n.com" 
          db_sid          = "CFRMAU01"                        
          db_port         = "1560"                            
          db_re_usr       = "MAIN_SCHEMA${local.env_id}"      
          db_cld_usr      = "CLOUD_SCHEMA${local.env_id}"     
          db_stg_usr      = "STAGING_SCHEMA${local.env_id}"    
          db_jobs_usr     = "JOBS_SCHEMA${local.env_id}"     
      }

    ## IC-FE
    cfrmfacts_ic    = {
      bt_customer      = local.facts.customer
      bt_product       = local.facts.product
      bt_role          = local.facts.role
      bt_tier          = local.facts.tier
      bt_lob           = "CFRM"
      bt_env           = "ic"
      bt_env_id        = local.env_id
      bt_ic_version    = local.facts.cfrm_version
      bt_cfrm_hosts    = local.cfrm_hosts
      bt_cfrm_db       = local.cfrm_db
      bt_cfrm_elk      = local.cfrm_elk
    }
    ## AE-BE 
    cfrmfacts_be    = {
      bt_customer      = local.facts.customer
      bt_product       = local.facts.product
      bt_role          = local.facts.role
      bt_tier          = local.facts.tier
      bt_lob           = "CFRM"
      bt_env           = "be"
      bt_env_id        = local.env_id
      bt_ic_version    = local.facts.cfrm_version
      bt_cfrm_hosts    = local.cfrm_hosts
      bt_cfrm_db       = local.cfrm_db
      bt_cfrm_elk      = local.cfrm_elk
    }
  
    datacenter = {
      name = "ny2"
      id   = "ny2"
  }
}

module "fmg-ic-01-be-lab01" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = local.cfrm_hosts.be_host1
  alias                = "cfrm-cloud-${local.facts.customer}-${local.facts.tier}-${local.env_id}-${local.datacenter.name}-be01" //
  bt_infra_network     = local.facts.bt_infra_network   ////  
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

module "fmg-ic-01-be-lab02" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = local.cfrm_hosts.be_host2
  alias                = "cfrm-cloud-${local.facts.customer}-${local.facts.tier}-${local.env_id}-${local.datacenter.name}-be02"
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

module "fmg-ic-01-fe-lab01" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = local.cfrm_hosts.ic_host1
  alias                = "cfrm-cloud-${local.facts.customer}-${local.facts.tier}-${local.env_id}-${local.datacenter.name}-ic01"
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
module "fmg-ic-01-fe-lab02" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = local.cfrm_hosts.ic_host2
  alias                = "cfrm-cloud-${local.facts.customer}-${local.facts.tier}-${local.env_id}-${local.datacenter.name}-ic02"
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

output "fmg-ic-01-be-lab01" {
  value = {
    "fqdn"  = module.fmg-ic-01-be-lab01.fqdn,
    "alias" = module.fmg-ic-01-be-lab01.alias,
    "ip"    = module.fmg-ic-01-be-lab01.ip,
  }
}

output "fmg-ic-01-be-lab02" {
  value = {
    "fqdn"  = module.fmg-ic-01-be-lab02.fqdn,
    "alias" = module.fmg-ic-01-be-lab02.alias,
    "ip"    = module.fmg-ic-01-be-lab02.ip,
  }
}
output "fmg-ic-01-fe-lab01" {
  value = {
    "fqdn"  = module.fmg-ic-01-fe-lab01.fqdn,
    "alias" = module.fmg-ic-01-fe-lab01.alias,
    "ip"    = module.fmg-ic-01-fe-lab01.ip,
  }
}

output "fmg-ic-01-fe-lab02" {
  value = {
    "fqdn"  = module.fmg-ic-01-fe-lab02.fqdn,
    "alias" = module.fmg-ic-01-fe-lab02.alias,
    "ip"    = module.fmg-ic-01-fe-lab02.ip,
  }
}