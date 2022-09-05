terraform {
  backend "s3" {}
}

locals {
  product          = "inf"
  environment      = "master"
  hostname         = "us01vl9wazuh"
  hostgroup        = "BT Base Server"
  bt_infra_cluster = "ny2-aze-ntnx-12"
  bt_infra_network = "ny2-autolab-app-ahv"
  os_version       = "rhel9"
  bt_lob           = "CLOUD"
  cpus             = "2"
  memory           = "4096"
  facts            = {
                     bt_product = "inf"
                     bt_tier    = "pr"
                     bt_role    = "base"
                     bt_env     = "master"
                   }
  datacenter       = {
                     name = "ny2"
                     id   = "us01"
                   }
}

module "rhel9ts01" {
  source              = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  hostname            = "${local.hostname}01"
  alias               = "${local.datacenter.id}-${local.product}-wzh01"
  bt_infra_cluster    = local.bt_infra_cluster
  bt_infra_network    = local.bt_infra_network
  os_version          = local.os_version
  bt_lob              = local.bt_lob
  cpus                = local.cpus
  memory              = local.memory
  external_facts      = local.facts
  foreman_environment = local.environment
  foreman_hostgroup   = local.hostgroup
  datacenter          = local.datacenter.name
}

output "rhel9ts01" {
  value = {
    "fqdn"  = module.rhel9ts01.fqdn,
    "alias" = module.rhel9ts01.alias,
    "ip"    = module.rhel9ts01.ip,
  }
}
module "rhel9ts02" {
  source              = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  hostname            = "${local.hostname}02"
  alias               = "${local.datacenter.id}-${local.product}-wzh02"
  bt_infra_cluster    = local.bt_infra_cluster
  bt_infra_network    = local.bt_infra_network
  os_version          = local.os_version
  bt_lob              = local.bt_lob
  cpus                = local.cpus
  memory              = local.memory
  external_facts      = local.facts
  foreman_environment = local.environment
  foreman_hostgroup   = local.hostgroup
  datacenter          = local.datacenter.name
}

output "rhel9ts02" {
  value = {
    "fqdn"  = module.rhel9ts02.fqdn,
    "alias" = module.rhel9ts02.alias,
    "ip"    = module.rhel9ts02.ip,
  }
}