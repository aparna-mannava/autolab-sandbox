terraform {
  backend "s3" {}
}

locals {
  lob           = "cea"
  image         = "rhel7"
  hostgroup     = "BT Base Server"
  environment   = "master"
  datacenter    = "ny2"
  cluster       = "ny2-azd-ntnx-10"
  network       = "ny2-autolab-app-ahv"
  cpus          = "4"
  memory        = "8192"
  disks     = {
    1 = "500",
  }
  facts         = {
    "bt_tier" = "ny2"
    "bt_env" = "99"
    "bt_confluent_cluster" = {
      "kafka": [
        "us01vlskb100",
        "us01vlskb101",
        "us01vlskb102",
      ],
      "zookeeper": [
        "us01vlskb100",
        "us01vlskb101",
        "us01vlskb102",
      ]
    }
  }
}

module "base_server_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlskb100"
  bt_infra_cluster     = local.cluster
  bt_infra_network     = local.network
  os_version           = local.image
  cpus                 = local.cpus
  memory               = local.memory
  foreman_environment  = local.environment
  foreman_hostgroup    = local.hostgroup
  datacenter           = local.datacenter
  external_facts       = local.facts
  lob                  = local.lob
}

module "base_server_2" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlskb101"
  bt_infra_cluster     = local.cluster
  bt_infra_network     = local.network
  os_version           = local.image
  cpus                 = local.cpus
  memory               = local.memory
  foreman_environment  = local.environment
  foreman_hostgroup    = local.hostgroup
  datacenter           = local.datacenter
  external_facts       = local.facts
  lob                  = local.lob
}

module "base_server_3" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlskb102"
  bt_infra_cluster     = local.cluster
  bt_infra_network     = local.network
  os_version           = local.image
  cpus                 = local.cpus
  memory               = local.memory
  foreman_environment  = local.environment
  foreman_hostgroup    = local.hostgroup
  datacenter           = local.datacenter
  external_facts       = local.facts
  lob                  = local.lob
}

output "base_server_1" {
  value = {
    "fqdn"  = "${module.base_server_1.fqdn}",
    "alias" = "${module.base_server_1.alias}",
    "ip"    = "${module.base_server_1.ip}",
  }
}

output "base_server_2" {
  value = {
    "fqdn"  = "${module.base_server_2.fqdn}",
    "alias" = "${module.base_server_2.alias}",
    "ip"    = "${module.base_server_2.ip}",
  }
}

output "base_server_3" {
  value = {
    "fqdn"  = "${module.base_server_3.fqdn}",
    "alias" = "${module.base_server_3.alias}",
    "ip"    = "${module.base_server_3.ip}",
  }
}
