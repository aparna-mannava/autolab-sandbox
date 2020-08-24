terraform {
  backend "http" {}
}

locals {
  lob           = "BTIQ"
  product       = "afs"
  image         = "rhel8"
  environment   = "feature_BTIQ_191_Provision_and_configure_Airflow"
  hostgroup     = "BTIQ CAE Airflow"
  datacenter    = "ny2"
  cluster       = "ny2-aza-vmw-autolab"
  network       = "ny2-autolab-app"
  hostname_base = "us01vl"
  cpu           = "1"
  memory        = "4096"
  facts         = {
    "bt_product"       = "btiq-cae"
    "bt_tier"          = "dev"
    "bt_env"           = ""
    "bt_role"          = "airflow-nfs-server"
  }
}

module "airflow-nfs-server" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "${local.hostname_base}btiq${local.product}01"
  alias                = "btiq-cae-${local.product}-01"
  lob                  = local.lob
  bt_infra_cluster     = local.cluster
  bt_infra_network     = local.network
  os_version           = local.image
  foreman_environment  = local.environment
  foreman_hostgroup    = local.hostgroup
  datacenter           = local.datacenter
  external_facts       = local.facts
  cpus                 = local.cpu
  memory               = local.memory
}

output "nfs-server" {
  value = {
    "fqdn"  = module.airflow-nfs-server.fqdn,
    "alias" = module.airflow-nfs-server.alias,
    "ip"    = module.airflow-nfs-server.ip,
  }
}
