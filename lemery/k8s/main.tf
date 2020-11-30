terraform {
  backend "s3" {}
}

locals {
  lob           = "cea"
  image         = "rhel7"
  mhostgroup    = "BT INF Kubernetes Master"
  whostgroup    = "BT INF Kubernetes Worker"
  environment   = "feature_CEA_6213_k8s_svc_ip_ranges"
  datacenter    = "ny2"
  cluster       = "ny2-aza-ntnx-05"
  network       = "ny2-autolab-app-ahv"
  cpus          = "4"
  memory        = "4096"
  disks     = {
    1 = "100",
  }
  mfacts         = {
    "bt_product"      = "inf"
    "bt_role"         = "kubernetes_master"
    "bt_tier"         = "autolab"
    "bt_env"          = "95"
  }
  wfacts         = {
    "bt_product" = "inf"
    "bt_role" = "kubernetes_worker"
    "bt_tier" = "autolab"
    "bt_env" = "95"
  }
}

module "master_server_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-k8s-infrastructure.git?ref=master"
  hostname             = "us01vlkm001"
  bt_infra_cluster     = local.cluster
  bt_infra_network     = local.network
  os_version           = local.image
  cpus                 = local.cpus
  memory               = local.memory
  foreman_environment  = local.environment
  foreman_hostgroup    = local.mhostgroup
  datacenter           = local.datacenter
  external_facts       = local.mfacts
  additional_disks     = local.disks
}

module "master_server_2" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-k8s-infrastructure.git?ref=master"
  hostname             = "us01vlkm002"
  bt_infra_cluster     = local.cluster
  bt_infra_network     = local.network
  os_version           = local.image
  cpus                 = local.cpus
  memory               = local.memory
  foreman_environment  = local.environment
  foreman_hostgroup    = local.mhostgroup
  datacenter           = local.datacenter
  external_facts       = local.mfacts
  additional_disks     = local.disks
}

module "master_server_3" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-k8s-infrastructure.git?ref=master"
  hostname             = "us01vlkm003"
  bt_infra_cluster     = local.cluster
  bt_infra_network     = local.network
  os_version           = local.image
  cpus                 = local.cpus
  memory               = local.memory
  foreman_environment  = local.environment
  foreman_hostgroup    = local.mhostgroup
  datacenter           = local.datacenter
  external_facts       = local.mfacts
  additional_disks     = local.disks
}

module "worker_server_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-k8s-infrastructure.git?ref=master"
  hostname             = "us01vlkw001"
  bt_infra_cluster     = local.cluster
  bt_infra_network     = local.network
  os_version           = local.image
  cpus                 = local.cpus
  memory               = local.memory
  foreman_environment  = local.environment
  foreman_hostgroup    = local.whostgroup
  datacenter           = local.datacenter
  external_facts       = local.wfacts
  additional_disks     = local.disks
}

module "worker_server_2" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-k8s-infrastructure.git?ref=master"
  hostname             = "us01vlkw002"
  bt_infra_cluster     = local.cluster
  bt_infra_network     = local.network
  os_version           = local.image
  cpus                 = local.cpus
  memory               = local.memory
  foreman_environment  = local.environment
  foreman_hostgroup    = local.whostgroup
  datacenter           = local.datacenter
  external_facts       = local.wfacts
  additional_disks     = local.disks
}

module "worker_server_3" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-k8s-infrastructure.git?ref=master"
  hostname             = "us01vlkw003"
  bt_infra_cluster     = local.cluster
  bt_infra_network     = local.network
  os_version           = local.image
  cpus                 = local.cpus
  memory               = local.memory
  foreman_environment  = local.environment
  foreman_hostgroup    = local.whostgroup
  datacenter           = local.datacenter
  external_facts       = local.wfacts
  additional_disks     = local.disks
}

output "master_server_1" {
  value = {
    "fqdn"  = "${module.master_server_1.fqdn}",
    "alias" = "${module.master_server_1.alias}",
    "ip"    = "${module.master_server_1.ip}",
  }
}
output "master_server_2" {
  value = {
    "fqdn"  = "${module.master_server_2.fqdn}",
    "alias" = "${module.master_server_2.alias}",
    "ip"    = "${module.master_server_2.ip}",
  }
}

output "master_server_3" {
  value = {
    "fqdn"  = "${module.master_server_3.fqdn}",
    "alias" = "${module.master_server_3.alias}",
    "ip"    = "${module.master_server_3.ip}",
  }
}

output "worker_server_1" {
  value = {
    "fqdn"  = "${module.worker_server_1.fqdn}",
    "alias" = "${module.worker_server_1.alias}",
    "ip"    = "${module.worker_server_1.ip}",
  }
}

output "worker_server_2" {
  value = {
    "fqdn"  = "${module.worker_server_2.fqdn}",
    "alias" = "${module.worker_server_2.alias}",
    "ip"    = "${module.worker_server_2.ip}",
  }
}

output "worker_server_3" {
  value = {
    "fqdn"  = "${module.worker_server_3.fqdn}",
    "alias" = "${module.worker_server_3.alias}",
    "ip"    = "${module.worker_server_3.ip}",
  }
}


