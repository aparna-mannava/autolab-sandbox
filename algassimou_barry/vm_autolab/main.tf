terraform {
  backend "s3" {}
}

locals {
  product       = "fmcloud"
  environment   = "master"
  hostgroup     = "BT Base Server"
  datacenter    = "ny2"
  image         = "rhel7"
  infra_cluster = "ny2-aza-vmw-autolab"
  infra_network = "ny2-autolab-app"
  facts         = {
    "bt_product"        = "FMCLOUD"
    "bt_loc"            = "ny2"
  }
}

module "vm_0" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlfma001"
  alias                = "fm-dev-fma1"
  bt_infra_cluster     = local.infra_cluster
  bt_infra_network     = local.infra_network
  os_version           = local.image
  foreman_environment  = local.environment
  foreman_hostgroup    = local.hostgroup
  datacenter           = local.datacenter
  external_facts       = local.facts
  cpus                 = "8"
  memory               = "3200"
  lob                  = local.facts.bt_product
  additional_disks     = {
    1 = "50",
    2 = "2000"
  }
}

output "vm_0" {
  value = {
    "fqdn"  = "${module.vm_0.fqdn}",
    "alias" = "${module.vm_0.alias}",
    "ip"    = "${module.vm_0.ip}",
  }
}

module "vm_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlfma002"
  alias                = "fm-dev-fma2"
  bt_infra_cluster     = local.infra_cluster
  bt_infra_network     = local.infra_network
  os_version           = local.image
  foreman_environment  = local.environment
  foreman_hostgroup    = local.hostgroup
  datacenter           = local.datacenter
  external_facts       = local.facts
  cpus                 = "8"
  memory               = "3200"
  lob                  = local.facts.bt_product
  additional_disks     = {
    1 = "50",
    2 = "2000"
  }
}

output "vm_1" {
  value = {
    "fqdn"  = "${module.vm_0.fqdn}",
    "alias" = "${module.vm_0.alias}",
    "ip"    = "${module.vm_0.ip}",
  }
}

module "vm_2" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlfma003"
  alias                = "fm-dev-fma3"
  bt_infra_cluster     = local.infra_cluster
  bt_infra_network     = local.infra_network
  os_version           = local.image
  foreman_environment  = local.environment
  foreman_hostgroup    = local.hostgroup
  datacenter           = local.datacenter
  external_facts       = local.facts
  cpus                 = "8"
  memory               = "3200"
  lob                  = local.facts.bt_product
  additional_disks     = {
    1 = "50",
    2 = "2000"
  }
}


output "vm_2" {
  value = {
    "fqdn"  = "${module.vm_0.fqdn}",
    "alias" = "${module.vm_0.alias}",
    "ip"    = "${module.vm_0.ip}",
  }
}

module "vm_3" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlfma004"
  alias                = "fm-dev-fma4"
  bt_infra_cluster     = local.infra_cluster
  bt_infra_network     = local.infra_network
  os_version           = local.image
  foreman_environment  = local.environment
  foreman_hostgroup    = local.hostgroup
  datacenter           = local.datacenter
  external_facts       = local.facts
  cpus                 = "8"
  memory               = "3200"
  lob                  = local.facts.bt_product
  additional_disks     = {
    1 = "50",
    2 = "2000"
  }
}

output "vm_3" {
  value = {
    "fqdn"  = "${module.vm_0.fqdn}",
    "alias" = "${module.vm_0.alias}",
    "ip"    = "${module.vm_0.ip}",
  }
}

module "vm_4" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlfma005"
  alias                = "fm-dev-fma5"
  bt_infra_cluster     = local.infra_cluster
  bt_infra_network     = local.infra_network
  os_version           = local.image
  foreman_environment  = local.environment
  foreman_hostgroup    = local.hostgroup
  datacenter           = local.datacenter
  external_facts       = local.facts
  cpus                 = "8"
  memory               = "3200"
  lob                  = local.facts.bt_product
  additional_disks     = {
    1 = "50",
    2 = "2000"
  }
}

output "vm_4" {
  value = {
    "fqdn"  = "${module.vm_0.fqdn}",
    "alias" = "${module.vm_0.alias}",
    "ip"    = "${module.vm_0.ip}",
  }
}

module "vm_5" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlfma006"
  alias                = "fm-dev-fma6"
  bt_infra_cluster     = local.infra_cluster
  bt_infra_network     = local.infra_network
  os_version           = local.image
  foreman_environment  = local.environment
  foreman_hostgroup    = local.hostgroup
  datacenter           = local.datacenter
  external_facts       = local.facts
  cpus                 = "8"
  memory               = "3200"
  lob                  = local.facts.bt_product
  additional_disks     = {
    1 = "50",
    2 = "2000"
  }
}

output "vm_5" {
  value = {
    "fqdn"  = "${module.vm_0.fqdn}",
    "alias" = "${module.vm_0.alias}",
    "ip"    = "${module.vm_0.ip}",
  }
}
