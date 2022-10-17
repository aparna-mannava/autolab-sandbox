terraform {
  backend "s3" {}
}
 
locals {
  base_vm = ["us01vlfmvm011", "us01vlfmvm012", "us01vlfmvm013"]
  domain = "auto.saas-n.com"
  tier = "dev"
  bt_env = "3"
  bt_product = "FMCLOUD"
  lob = "FMCLOUD"
  hostgroup = "BT FMCLOUD perftest" #######. HOST GROUP
  environment = "master"
  cluster = "ny2-aze-ntnx-12"
  network = "ny2-autolab-app-ahv"
  datacenter = "ny2"
  facts = {
    "bt_env" = "${local.bt_env}"
    "bt_tier" = "${local.tier}"
    "bt_product" = "${local.bt_product}"
  }
}


module "vm_1" {
  source               = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  os_version = "rhel8"
  cpus = "8"
  memory = "16384"
  hostname = "${local.base_vm[0]}"
  bt_infra_cluster = local.cluster
  bt_infra_network = local.network
  lob = local.lob
  foreman_environment  = local.environment
  foreman_hostgroup    = local.hostgroup
  datacenter           = local.datacenter
  external_facts       = local.facts
  additional_disks     = {
    1 = "20"
  }
}

module "vm_2" {
  source               = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  os_version = "rhel8"
  cpus = "8"
  memory = "16384"
  hostname = "${local.base_vm[1]}"
  bt_infra_cluster = local.cluster
  bt_infra_network = local.network
  lob = local.lob
  foreman_environment  = local.environment
  foreman_hostgroup    = local.hostgroup
  datacenter           = local.datacenter
  external_facts       = local.facts
  additional_disks     = {
    1 = "20"
  }
}


module "vm_3" {
  source               = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  os_version = "rhel8"
  cpus = "8"
  memory = "16384"
  hostname = "${local.base_vm[2]}"
  bt_infra_cluster = local.cluster
  bt_infra_network = local.network
  lob = local.lob
  foreman_environment  = local.environment
  foreman_hostgroup    = local.hostgroup
  datacenter           = local.datacenter
  external_facts       = local.facts
  additional_disks     = {
    1 = "20"
  }
}

output "vm_1" {
  value = {
    "fqdn"  = "${module.vm_1.fqdn}",
    "alias" = "${module.vm_1.alias}",
    "ip"    = "${module.vm_1.ip}",
  }
}
output "vm_2" {
  value = {
    "fqdn"  = "${module.vm_2.fqdn}",
    "alias" = "${module.vm_2.alias}",
    "ip"    = "${module.vm_2.ip}",
  }
}
output "vm_3" {
  value = {
    "fqdn"  = "${module.vm_3.fqdn}",
    "alias" = "${module.vm_3.alias}",
    "ip"    = "${module.vm_3.ip}",
  }
}
 