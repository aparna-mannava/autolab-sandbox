terraform {
  backend "s3" {}
}

module "harbor1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlhrbr181"
  bt_infra_cluster     = "ny2-aza-ntnx-07"
  bt_infra_network     = "ny2-autolab-app-ahv"
  os_version           = "rhel7"
  cpus                 = "4"
  datacenter           = "ny2"
  foreman_environment  = "master"
  foreman_hostgroup    = "BT Base Server"
  lob                  = "CLOUD"
  memory               = "4096"
  additional_disks     = {
    1 = "500",
  }
  external_facts       = {
    "bt_product" = "cloud"
    "bt_role"    = "bt_base_server"
    "bt_tier"    = "autolab"
  }
}

module "harbor2" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlhrbr182"
  bt_infra_cluster     = "ny2-aza-ntnx-07"
  bt_infra_network     = "ny2-autolab-app-ahv"
  os_version           = "rhel7"
  cpus                 = "4"
  datacenter           = "ny2"
  foreman_environment  = "master"
  foreman_hostgroup    = "BT Base Server"
  lob                  = "CLOUD"
  memory               = "4096"
  additional_disks     = {
    1 = "500",
  }
  external_facts       = {
    "bt_product" = "cloud"
    "bt_role"    = "bt_base_server"
    "bt_tier"    = "autolab"
  }
}
