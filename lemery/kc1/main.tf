terraform {
  backend "s3" {}
}

locals {
  lob                 = "cea"
  image               = "rhel7"
  hostgroup           = "BT Small Kafka Broker Server"
  platform_hostgroup  = "BT Small Kafka Platform Server"
  environment         = "feature_CEA_9281_akhq_ldap_auth"
  platform_environment = "master"
  datacenter          = "ny2"
  cluster             = "ny2-azd-ntnx-10"
  network             = "ny2-autolab-app-ahv"
  cpus                = "4"
  memory              = "8192"
  disks               = {
    1 = "700",
  }
  facts              = {
    "bt_tier" = "ny2"
    "bt_env" = "99"
    "bt_confluent_cluster" = {
      "kafka": [
        "us01vlskfkb100",
        "us01vlskfkb101",
        "us01vlskfkb102",
      ],
      "zookeeper": [
        "us01vlskfkb100",
        "us01vlskfkb101",
        "us01vlskfkb102",
      ]
    }
  }
}

module "base_server_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlskfkb100"
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
  hostname             = "us01vlskfkb101"
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
  hostname             = "us01vlskfkb102"
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

module "base_server_4" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlskfkp100"
  bt_infra_cluster     = local.cluster
  bt_infra_network     = local.network
  os_version           = local.image
  cpus                 = local.cpus
  memory               = local.memory
  foreman_environment  = local.platform_environment
  foreman_hostgroup    = local.platform_hostgroup
  datacenter           = local.datacenter
  external_facts       = local.facts
  lob                  = local.lob
}

module "base_server_5" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlskfkp101"
  bt_infra_cluster     = local.cluster
  bt_infra_network     = local.network
  os_version           = local.image
  cpus                 = local.cpus
  memory               = local.memory
  foreman_environment  = local.platform_environment
  foreman_hostgroup    = local.platform_hostgroup
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

output "base_server_4" {
  value = {
    "fqdn"  = "${module.base_server_4.fqdn}",
    "alias" = "${module.base_server_4.alias}",
    "ip"    = "${module.base_server_4.ip}",
  }
}

output "base_server_5" {
  value = {
    "fqdn"  = "${module.base_server_5.fqdn}",
    "alias" = "${module.base_server_5.alias}",
    "ip"    = "${module.base_server_5.ip}",
  }
}
