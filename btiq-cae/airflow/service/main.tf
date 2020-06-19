terraform {
  backend "http" {}
}

locals {
  lob           = "BTIQ-CAE"
  product       = "air"
  image         = "rhel8"
  environment   = "feature_BTIQ_191_Provision_and_configure_Airflow"
  hostgroup     = "BTIQ CAE Airflow"
  datacenter    = "ny2"
  cluster       = "ny2-aza-vmw-autolab"
  network       = "ny2-autolab-app"
  hostname_base = "us01vl"
  cpu           = "2"
  memory        = "8192"
  facts         = {
    "bt_product"       = "btiq_cae"
    "bt_tier"          = "dev"
    "bt_env"           = ""
    "bt_role"          = "airflow"
  }
  additional_disks     = {
      1 = "50",
      2 = "310",
  }
}

module "airflow-service" {
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
  additional_disks     = local.additional_disks
}

output "airflow-service" {
  value = {
    "fqdn"  = module.airflow-service.fqdn,
    "alias" = module.airflow-service.alias,
    "ip"    = module.airflow-service.ip,
  }
}
