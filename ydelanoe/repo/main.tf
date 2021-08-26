terraform {
  backend "s3" {}
}

locals {
  product       = "FMCLOUD"
  environment   = "master"
  hostgroup     = "BT FM Cloud Repo Server"
  datacenter    = "ny2"
  image         = "rhel7"
  infra_cluster = "ny2-azd-ntnx-10"
  infra_network = "ny2-autolab-app-ahv"
  facts         = {
    "bt_product"        = "fmcloud"
    "bt_tier"           = "dev"
    "bt_loc"            = "ny2"
    "bt_role"           = "repo"
  }
}

module "scp_repo" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlfm${local.facts.bt_role}001"
  alias                = "fm-${local.facts.bt_tier}-${local.facts.bt_role}"
  bt_infra_cluster     = local.infra_cluster
  bt_infra_network     = local.infra_network
  os_version           = local.image
  foreman_environment  = local.environment
  foreman_hostgroup    = local.hostgroup
  datacenter           = local.datacenter
  external_facts       = local.facts
  cpus                 = "1"
  memory               = "1024"
  lob                  = local.facts.bt_product
}

output "scp_repo" {
  value = {
    "fqdn"  = module.scp_repo.fqdn,
    "alias" = module.scp_repo.alias,
    "ip"    = module.scp_repo.ip,
  }
}
