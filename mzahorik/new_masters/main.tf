terraform {
  backend "s3" {}
}

# System info

locals {
  domain       = "auto.saas-n.com"
  cluster_name = "ny2lab71"
  master_vip   = "10.226.191.210"
  tier         = "autolab"
  product      = "inf"
  lob          = "INF"
  owner        = "cloudsystemsengineers"
}

module "us01vlk8smbus74" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlk8smbus74"
  bt_infra_cluster     = "ny2-aze-ntnx-11"
  bt_infra_network     = "ny2-autolab-db-ahv"
  os_version           = "rhel8"
  cpus                 = "4"
  memory               = "8192"
  lob                  = local.lob
  owner                = local.owner
  foreman_environment  = "feature_CEA_7234"
  foreman_hostgroup    = "BT Base Server"
  external_facts       = {
    "bt_env"            = local.cluster_name
    "bt_k8s_master_vip" = local.master_vip
    "bt_product"        = local.product
    "bt_tier"           = local.tier
  }
  datacenter           = "ny2"
  additional_disks     = {
    1 = "100"
  }
}

module "us01vlk8smbus75" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlk8smbus75"
  bt_infra_cluster     = "ny2-aze-ntnx-11"
  bt_infra_network     = "ny2-autolab-db-ahv"
  os_version           = "rhel8"
  cpus                 = "4"
  memory               = "8192"
  lob                  = local.lob
  owner                = local.owner
  foreman_environment  = "feature_CEA_7234"
  foreman_hostgroup    = "BT Base Server"
  external_facts       = {
    "bt_env"            = local.cluster_name
    "bt_k8s_master_vip" = local.master_vip
    "bt_product"        = local.product
    "bt_tier"           = local.tier
  }
  datacenter           = "ny2"
  additional_disks     = {
    1 = "100"
  }
}

module "us01vlk8smbus76" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlk8smbus76"
  bt_infra_cluster     = "ny2-aze-ntnx-11"
  bt_infra_network     = "ny2-autolab-db-ahv"
  os_version           = "rhel8"
  cpus                 = "4"
  memory               = "8192"
  lob                  = local.lob
  owner                = local.owner
  foreman_environment  = "feature_CEA_7234"
  foreman_hostgroup    = "BT Base Server"
  external_facts       = {
    "bt_env"            = local.cluster_name
    "bt_k8s_master_vip" = local.master_vip
    "bt_product"        = local.product
    "bt_tier"           = local.tier
  }
  datacenter           = "ny2"
  additional_disks     = {
    1 = "100"
  }
}

