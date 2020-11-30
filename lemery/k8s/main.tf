terraform {
  backend "s3" {}
}

module "k8s_inf_us01auto1" {
  source              = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-k8s-infrastructure.git?ref=master"
  k8s_masters         = ["us01vlkm001", "us01vlkm002", "us01vlkm003"]
  master_cpus         = 8
  master_memory       = 16384
  domain              = "auto.saas-n.com"
  bt_infra_cluster    = "ny2-aza-ntnx-05"
  bt_infra_network    = "ny2-autolab-app-ahv"
  datacenter          = "ny2"
  os_version          = "rhel7"
  foreman_environment = "master"
  additional_disks    = ["100"]
  external_facts = {
    "bt_product" = "inf"
    "bt_tier"    = "autolab"
    "bt_env"     = "94"
  }
}
