terraform {
  backend "s3" {}
}

locals {
    facts       = {
      bt_customer      = "ny2"
      bt_product       = "cfrmcloud"
      bt_lob           = "CFRM"  
      bt_tier          = "dev"
      bt_env           = "01"
      bt_role          = "mgmt" 
      bt_infra_network = "ny2-autolab-app-ahv"
      bt_infra_cluster = "ny2-aze-ntnx-12"
      hostgroup        = "CFRM BT CLOUD NFS Server"
      environment      = "master"
      hostname         = "us01vlcfrmcp"
    }
    datacenter = {
      name = "ny2"
      id   = "ny2"
  }
    mgmt_nfs_01 = {
      "bt_customer"   = local.facts.bt_customer
      "bt_product"    = local.facts.bt_product
      "bt_tier"       = local.facts.bt_tier
      "bt_env"        = local.facts.bt_env
      "bt_role"       = local.facts.bt_role
      "bt_lob"        = local.facts.bt_lob
      "sql_exporter"  = false
     }
}

module "dev_autolab_1" {
  source               = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  hostname             = "${local.facts.hostname}01" //    us01vlcfrmcp01.auto.saas-n.com
  alias                = "${local.facts.bt_product}-${local.datacenter.id}-dev-base01" //cfrmcloud-ny2-dev-base01.auto.saas-n.com
  bt_infra_cluster     = local.facts.bt_infra_cluster
  bt_infra_network     = local.facts.bt_infra_network
  owner                = "CFRMCloudDevOpsTeam@bottomline.com"
  lob                  = local.facts.bt_lob
  foreman_environment  = local.facts.environment
  foreman_hostgroup    = local.facts.hostgroup
  datacenter           = local.datacenter.name
  external_facts       = local.mgmt_nfs_01
  os_version           = "rhel8"
  cpus                 = "4"
  memory         	     = "4096"
  additional_disks     = {
    1 = "30"
  }
}

output "dev_autolab_1" {
  value = {
    "fqdn"  = module.dev_autolab_1.fqdn,
    "alias" = module.dev_autolab_1.alias,
    "ip"    = module.dev_autolab_1.ip,
  }
}