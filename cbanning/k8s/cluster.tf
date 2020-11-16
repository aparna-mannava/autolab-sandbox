terraform {
  backend "s3" {}
}

module "k8s_test1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-k8s-infrastructure.git?ref=master"
  k8s_masters          = ["us01vlk8smcsb01", "us01vlk8smcsb02", "us01vlk8smcsb03"]
  k8s_workers          = ["us01vlk8swcsb01", "us01vlk8swcsb02"]
  master_cpus          = 4
  master_memory        = 8192
  worker_cpus          = 8
  worker_memory        = 16384
  domain               = "auto.saas-n.com"
  bt_infra_cluster     = "ny2-aza-vmw-autolab"
  bt_infra_network     = "ny2-autolab-app"
  datacenter           = "ny2"
  os_version           = "rhel8"
  foreman_environment  = "master"
  additional_disks     = ["100"]
  external_facts       = {
    "bt_product" = "inf"
    "bt_tier" = "dev"
    "bt_env"  = "99"
  }
}
