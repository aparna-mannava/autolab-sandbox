terraform {
  backend "s3" {}
}

module "harbor" {
  source              = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname            = "us01vlhrbr2000" 
  bt_infra_cluster    = "ny2-aza-ntnx-05"
  bt_infra_network    = "ny2-autolab-app-ahv"
  datacenter          = "ny2"
  lob                 = "CEA"
  cpus                = "2"
  memory              = "4096"
  os_version          = "rhel7"
  foreman_environment = "feature_CEA_9500_Harbor_Testing"
  foreman_hostgroup   = "BT Base Server" 
  additional_disks     = {
    1 = "100"
  }
  external_facts = {
    "bt_product" = "cloud"
    "bt_lob"     = "CEA"
    "bt_role"    = "base"
    "bt_tier"    = "dev"
    "bt_env"     = "1"
  }
}