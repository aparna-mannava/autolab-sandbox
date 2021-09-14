terraform {
  backend "s3" {}
}

locals {
  cluster     = "ny5-azc-ntnx-16"
  datacenter  = "ny2"
  domain      = "auto.saas-n.com"
  environment = "master"
  etcd        = ["us01vletcdz01","us01vletcdz02","us01vletcdz03"]
  hostgroup   = "BT Base Server"
  lob         = "CLOUD"
  network     = "ny2-autolab-app-ahv"
  facts       = {
    "bt_env"                  = "autolab"
    "bt_etcd_cluster_members" = [for member in local.etcd : "${member}.${local.domain}"]
    "bt_product"              = "cloud"
    "bt_role"                 = "etcd"
    "bt_tier"                 = "1"
  }
}

module "etcd1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = local.etcd[0]
  bt_infra_cluster     = local.cluster
  bt_infra_network     = local.network
  cpus                 = "2"
  datacenter           = local.datacenter
  external_facts       = local.facts
  foreman_environment  = local.environment
  foreman_hostgroup    = local.hostgroup
  lob                  = local.lob
  memory               = "4096"
  os_version           = "rhel7"  
  additional_disks     = {
    1 = "200",
  }
}

module "etcd2" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = local.etcd[1]
  bt_infra_cluster     = local.cluster
  bt_infra_network     = local.network
  cpus                 = "2"
  datacenter           = local.datacenter
  external_facts       = local.facts
  foreman_environment  = local.environment
  foreman_hostgroup    = local.hostgroup
  lob                  = local.lob
  memory               = "4096"
  os_version           = "rhel7"  
  additional_disks     = {
    1 = "200",
  }
}

module "etcd3" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = local.etcd[2]
  bt_infra_cluster     = local.cluster
  bt_infra_network     = local.network
  cpus                 = "2"
  datacenter           = local.datacenter
  external_facts       = local.facts
  foreman_environment  = local.environment
  foreman_hostgroup    = local.hostgroup
  lob                  = local.lob
  memory               = "4096"
  os_version           = "rhel7"  
  additional_disks     = {
    1 = "200",
  }
}
