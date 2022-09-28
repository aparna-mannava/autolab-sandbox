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
      bt_infra_cluster = "ny5-aze-ntnx-21"
      hostgroup        = "BT CFRM CLOUD MGMT Base"
      environment      = "feature_CFRMCLOUD_2547_manage_cfrmcloud_related_users_authorized_keys" //
      hostname         = "us01vlcfrmnfs"
    }
    datacenter = {
      name = "ny2"
      id   = "ny2"
  }
    mgmt_nfs_01 = {
      "bt_customer" = local.facts.bt_customer
      "bt_product"  = local.facts.bt_product
      "bt_tier"     = local.facts.bt_tier
      "bt_env"      = local.facts.bt_env
      "bt_role"     = local.facts.bt_role
      "bt_lob"      = local.facts.bt_lob
     }
}

module "nfsdev_autolab_1" {
  source               = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  hostname             = "${local.facts.hostname}01" //    us01vlcfrmnfs.autolab.saas-n.com
  alias                = "${local.facts.bt_product}-${local.datacenter.id}-dev-nfs01"//cfrmcloud-ny2-dev-nfs01.autolab.saas-n.com
  bt_infra_cluster     = local.facts.bt_infra_cluster
  bt_infra_network     = local.facts.bt_infra_network
  //firewall_group       = local.facts.firewall_group
  lob                  = local.facts.bt_lob
  foreman_environment  = local.facts.environment
  foreman_hostgroup    = local.facts.hostgroup
  datacenter           = local.datacenter.name
  external_facts       = local.mgmt_nfs_01
  os_version           = "rhel7"
  cpus                 = "4"
  memory         	     = "8192"
  additional_disks     = {
    1 = "70"
  }
}

output "nfsdev_autolab_1" {
  value = {
    "fqdn"  = module.nfsdev_autolab_1.fqdn,
    "alias" = module.nfsdev_autolab_1.alias,
    "ip"    = module.nfsdev_autolab_1.ip,
  }
}