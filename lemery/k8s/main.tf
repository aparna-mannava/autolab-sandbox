terraform {
  backend "s3" {}
}

resource "random_string" "token1" {
  length  = 6
  upper   = false
  special = false
}

resource "random_string" "token2" {
  length  = 16
  upper   = false
  special = false
}

module "kubernetes" {
  source                  = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-kubernetes.git?ref=master"
  cluster_token           = "${random_string.token1.result}.${random_string.token2.result}"
  additional_disks        = ["100"]
  datacenter              = "ny2"
  domain                  = "auto.saas-n.com"
  foreman_environment     = "feature_CEA_6213_k8s_svc_ip_ranges"
  k8s_masters             = ["us01vlkm01","us01vlkm02","us01vlkm03"]
  k8s_workers             = ["us01vlkw01","us01vlkw02"]
  master_cpus             = 4
  master_memory           = 8192
  os_version              = "rhel7"
  worker_cpus             = 4
  worker_memory           = 8192
  bt_infra_cluster        = "ny2-aza-ntnx-05"
  bt_infra_network        = "ny2-autolab-app-ahv"
}
