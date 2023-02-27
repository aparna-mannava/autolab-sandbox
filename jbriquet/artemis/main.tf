#redeploy
terraform {
  backend "s3" {}
}

locals {
  artemis_primary       = ["us01vlfmamqpr01","us01vlfmamqpr02","us01vlfmamqpr03", "us01vlfmamqpr04","us01vlfmamqpr05","us01vlfmamqpr06"]
  artemis_backup        = ["us01vlfmamqbk01","us01vlfmamqbk02","us01vlfmamqbk03", "us01vlfmamqbk04","us01vlfmamqbk05","us01vlfmamqbk06"]
  os_version            = "rhel8"
  lob                   = "FMCLOUD"
  cluster               = "ny5-aza-ntnx-19"
  network               = "ny2-autolab-app-ahv"
  product               = "fmcloud"
  environment           = "feature_FMDO_4762"
  domain                = "auto.saas-n.com"
  artemis_datacenter    = "ny2"

  facts  = {
    bt_env                      = "1"
    bt_tier                     = "autolab"
    bt_product                  = "fmcloud"
    bt_role                     = "artemismq"
    bt_country                  = "us"
    bt_datacenter               = "ny2"
    bt_foreman_hostgroup        = "BT FMCLOUD Artemis MQ"
    bt_artemis_version          = "2.24.0"
  }
}

module "artemis_primary_0" {
  source               = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  hostname             = local.artemis_primary[0]
  alias                = "fm-${local.facts.bt_country}-${local.facts.bt_tier}-primary-${local.facts.bt_role}1"
  bt_infra_cluster     = local.cluster
  bt_infra_network     = local.network
  os_version           = local.os_version
  cpus                 = "4"
  memory               = "16384"
  lob                  = local.lob
  external_facts       = {
    bt_artemis_primary_members  = ["${local.artemis_primary[0]}.${local.domain}", "${local.artemis_primary[1]}.${local.domain}", "${local.artemis_primary[2]}.${local.domain}", "${local.artemis_primary[3]}.${local.domain}", "${local.artemis_primary[4]}.${local.domain}", "${local.artemis_primary[5]}.${local.domain}"]
    bt_artemis_backup_members   = ["${local.artemis_backup[0]}.${local.domain}", "${local.artemis_backup[1]}.${local.domain}", "${local.artemis_backup[2]}.${local.domain}", "${local.artemis_backup[3]}.${local.domain}", "${local.artemis_backup[4]}.${local.domain}", "${local.artemis_backup[5]}.${local.domain}"]
    bt_product                  = "${local.facts.bt_product}"
    bt_tier                     = "${local.facts.bt_tier}"
    bt_env                      = "${local.facts.bt_env}"
    bt_artemis_version          = "${local.facts.bt_artemis_version}"
    bt_role                     = "${local.facts.bt_role}"
    bt_server_number            = 1
    bt_server_mode              = "primary"
    bt_amq_cluster_name         = "cluster-${local.facts.bt_role}-${local.facts.bt_country}-autolab"
  }
  foreman_hostgroup    = local.facts.bt_foreman_hostgroup
  foreman_environment  = local.environment
  datacenter           = local.facts.bt_datacenter
  additional_disks     = {
    1 = "200",
    2 = "2000",
  }
}

module "artemis_primary_1" {
  source               = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  hostname             = local.artemis_primary[1]
  alias                = "fm-${local.facts.bt_country}-${local.facts.bt_tier}-primary-${local.facts.bt_role}2"
  bt_infra_cluster     = local.cluster
  bt_infra_network     = local.network
  os_version           = local.os_version
  cpus                 = "4"
  memory               = "16384"
  lob                  = local.lob
  external_facts       = {
    bt_artemis_primary_members  = ["${local.artemis_primary[0]}.${local.domain}", "${local.artemis_primary[1]}.${local.domain}", "${local.artemis_primary[2]}.${local.domain}", "${local.artemis_primary[3]}.${local.domain}", "${local.artemis_primary[4]}.${local.domain}", "${local.artemis_primary[5]}.${local.domain}"]
    bt_artemis_backup_members   = ["${local.artemis_backup[0]}.${local.domain}", "${local.artemis_backup[1]}.${local.domain}", "${local.artemis_backup[2]}.${local.domain}", "${local.artemis_backup[3]}.${local.domain}", "${local.artemis_backup[4]}.${local.domain}", "${local.artemis_backup[5]}.${local.domain}"]
    bt_product                  = "${local.facts.bt_product}"
    bt_tier                     = "${local.facts.bt_tier}"
    bt_env                      = "${local.facts.bt_env}"
    bt_artemis_version          = "${local.facts.bt_artemis_version}"
    bt_role                     = "${local.facts.bt_role}"
    bt_server_mode              = "primary"
    bt_server_number            = 2
    bt_amq_cluster_name         = "cluster-${local.facts.bt_role}-${local.facts.bt_country}-autolab"
  }
  foreman_hostgroup    = local.facts.bt_foreman_hostgroup
  foreman_environment  = local.environment
  datacenter           = local.facts.bt_datacenter
  additional_disks     = {
    1 = "200",
    2 = "2000",
  }
}

module "artemis_primary_2" {
  source               = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  hostname             = local.artemis_primary[2]
  alias                = "fm-${local.facts.bt_country}-${local.facts.bt_tier}-primary-${local.facts.bt_role}3"
  bt_infra_cluster     = local.cluster
  bt_infra_network     = local.network
  os_version           = local.os_version
  cpus                 = "4"
  memory               = "16384"
  lob                  = local.lob
  external_facts       = {
    bt_artemis_primary_members  = ["${local.artemis_primary[0]}.${local.domain}", "${local.artemis_primary[1]}.${local.domain}", "${local.artemis_primary[2]}.${local.domain}", "${local.artemis_primary[3]}.${local.domain}", "${local.artemis_primary[4]}.${local.domain}", "${local.artemis_primary[5]}.${local.domain}"]
    bt_artemis_backup_members   = ["${local.artemis_backup[0]}.${local.domain}", "${local.artemis_backup[1]}.${local.domain}", "${local.artemis_backup[2]}.${local.domain}", "${local.artemis_backup[3]}.${local.domain}", "${local.artemis_backup[4]}.${local.domain}", "${local.artemis_backup[5]}.${local.domain}"]
    bt_product                  = "${local.facts.bt_product}"
    bt_tier                     = "${local.facts.bt_tier}"
    bt_env                      = "${local.facts.bt_env}"
    bt_artemis_version          = "${local.facts.bt_artemis_version}"
    bt_role                     = "${local.facts.bt_role}"
    bt_server_mode              = "primary"
    bt_server_number            = 3
    bt_amq_cluster_name         = "cluster-${local.facts.bt_role}-${local.facts.bt_country}-autolab"
  }
  foreman_hostgroup    = local.facts.bt_foreman_hostgroup
  foreman_environment  = local.environment
  datacenter           = local.facts.bt_datacenter
  additional_disks     = {
    1 = "200",
    2 = "2000",
  }
}

module "artemis_primary_3" {
  source               = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  hostname             = local.artemis_primary[3]
  alias                = "fm-${local.facts.bt_country}-${local.facts.bt_tier}-primary-${local.facts.bt_role}4"
  bt_infra_cluster     = local.cluster
  bt_infra_network     = local.network
  os_version           = local.os_version
  cpus                 = "4"
  memory               = "16384"
  lob                  = local.lob
  external_facts       = {
    bt_artemis_primary_members  = ["${local.artemis_primary[0]}.${local.domain}", "${local.artemis_primary[1]}.${local.domain}", "${local.artemis_primary[2]}.${local.domain}", "${local.artemis_primary[3]}.${local.domain}", "${local.artemis_primary[4]}.${local.domain}", "${local.artemis_primary[5]}.${local.domain}"]
    bt_artemis_backup_members   = ["${local.artemis_backup[0]}.${local.domain}", "${local.artemis_backup[1]}.${local.domain}", "${local.artemis_backup[2]}.${local.domain}", "${local.artemis_backup[3]}.${local.domain}", "${local.artemis_backup[4]}.${local.domain}", "${local.artemis_backup[5]}.${local.domain}"]
    bt_product                  = "${local.facts.bt_product}"
    bt_tier                     = "${local.facts.bt_tier}"
    bt_env                      = "${local.facts.bt_env}"
    bt_artemis_version          = "${local.facts.bt_artemis_version}"
    bt_role                     = "${local.facts.bt_role}"
    bt_server_mode              = "primary"
    bt_server_number            = 4
    bt_amq_cluster_name         = "cluster-${local.facts.bt_role}-${local.facts.bt_country}-autolab"
  }
  foreman_hostgroup    = local.facts.bt_foreman_hostgroup
  foreman_environment  = local.environment
  datacenter           = local.facts.bt_datacenter
  additional_disks     = {
    1 = "200",
    2 = "2000",
  }
}

module "artemis_primary_4" {
  source               = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  hostname             = local.artemis_primary[4]
  alias                = "fm-${local.facts.bt_country}-${local.facts.bt_tier}-primary-${local.facts.bt_role}5"
  bt_infra_cluster     = local.cluster
  bt_infra_network     = local.network
  os_version           = local.os_version
  cpus                 = "4"
  memory               = "16384"
  lob                  = local.lob
  external_facts       = {
    bt_artemis_primary_members  = ["${local.artemis_primary[0]}.${local.domain}", "${local.artemis_primary[1]}.${local.domain}", "${local.artemis_primary[2]}.${local.domain}", "${local.artemis_primary[3]}.${local.domain}", "${local.artemis_primary[4]}.${local.domain}", "${local.artemis_primary[5]}.${local.domain}"]
    bt_artemis_backup_members   = ["${local.artemis_backup[0]}.${local.domain}", "${local.artemis_backup[1]}.${local.domain}", "${local.artemis_backup[2]}.${local.domain}", "${local.artemis_backup[3]}.${local.domain}", "${local.artemis_backup[4]}.${local.domain}", "${local.artemis_backup[5]}.${local.domain}"]
    bt_product                  = "${local.facts.bt_product}"
    bt_tier                     = "${local.facts.bt_tier}"
    bt_env                      = "${local.facts.bt_env}"
    bt_artemis_version          = "${local.facts.bt_artemis_version}"
    bt_role                     = "${local.facts.bt_role}"
    bt_server_mode              = "primary"
    bt_server_number            = 5
    bt_amq_cluster_name         = "cluster-${local.facts.bt_role}-${local.facts.bt_country}-autolab"
  }
  foreman_hostgroup    = local.facts.bt_foreman_hostgroup
  foreman_environment  = local.environment
  datacenter           = local.facts.bt_datacenter
  additional_disks     = {
    1 = "200",
    2 = "2000",
  }
}

module "artemis_primary_5" {
  source               = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  hostname             = local.artemis_primary[5]
  alias                = "fm-${local.facts.bt_country}-${local.facts.bt_tier}-primary-${local.facts.bt_role}6"
  bt_infra_cluster     = local.cluster
  bt_infra_network     = local.network
  os_version           = local.os_version
  cpus                 = "4"
  memory               = "16384"
  lob                  = local.lob
  external_facts       = {
    bt_artemis_primary_members  = ["${local.artemis_primary[0]}.${local.domain}", "${local.artemis_primary[1]}.${local.domain}", "${local.artemis_primary[2]}.${local.domain}", "${local.artemis_primary[3]}.${local.domain}", "${local.artemis_primary[4]}.${local.domain}", "${local.artemis_primary[5]}.${local.domain}"]
    bt_artemis_backup_members   = ["${local.artemis_backup[0]}.${local.domain}", "${local.artemis_backup[1]}.${local.domain}", "${local.artemis_backup[2]}.${local.domain}", "${local.artemis_backup[3]}.${local.domain}", "${local.artemis_backup[4]}.${local.domain}", "${local.artemis_backup[5]}.${local.domain}"]
    bt_product                  = "${local.facts.bt_product}"
    bt_tier                     = "${local.facts.bt_tier}"
    bt_env                      = "${local.facts.bt_env}"
    bt_artemis_version          = "${local.facts.bt_artemis_version}"
    bt_role                     = "${local.facts.bt_role}"
    bt_server_mode              = "primary"
    bt_server_number            = 6
    bt_amq_cluster_name         = "cluster-${local.facts.bt_role}-${local.facts.bt_country}-autolab"
  }
  foreman_hostgroup    = local.facts.bt_foreman_hostgroup
  foreman_environment  = local.environment
  datacenter           = local.facts.bt_datacenter
  additional_disks     = {
    1 = "200",
    2 = "2000",
  }
}

module "artemis_backup_0" {
  source               = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  hostname             = local.artemis_backup[0]
  alias                = "fm-${local.facts.bt_country}-${local.facts.bt_tier}-backup-${local.facts.bt_role}1"
  bt_infra_cluster     = local.cluster
  bt_infra_network     = local.network
  os_version           = local.os_version
  cpus                 = "4"
  memory               = "16384"
  lob                  = local.lob
  external_facts       = {
    bt_artemis_primary_members  = ["${local.artemis_primary[0]}.${local.domain}", "${local.artemis_primary[1]}.${local.domain}", "${local.artemis_primary[2]}.${local.domain}", "${local.artemis_primary[3]}.${local.domain}", "${local.artemis_primary[4]}.${local.domain}", "${local.artemis_primary[5]}.${local.domain}"]
    bt_artemis_backup_members   = ["${local.artemis_backup[0]}.${local.domain}", "${local.artemis_backup[1]}.${local.domain}", "${local.artemis_backup[2]}.${local.domain}", "${local.artemis_backup[3]}.${local.domain}", "${local.artemis_backup[4]}.${local.domain}", "${local.artemis_backup[5]}.${local.domain}"]
    bt_product                  = "${local.facts.bt_product}"
    bt_tier                     = "${local.facts.bt_tier}"
    bt_env                      = "${local.facts.bt_env}"
    bt_artemis_version          = "${local.facts.bt_artemis_version}"
    bt_role                     = "${local.facts.bt_role}"
    bt_server_number            = 1
    bt_server_mode              = "backup"
    bt_amq_cluster_name         = "cluster-${local.facts.bt_role}-${local.facts.bt_country}-autolab"
  }
  foreman_hostgroup    = local.facts.bt_foreman_hostgroup
  foreman_environment  = local.environment
  datacenter           = local.facts.bt_datacenter
  additional_disks     = {
    1 = "200",
    2 = "2000",
  }
}

module "artemis_backup_1" {
  source               = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  hostname             = local.artemis_backup[1]
  alias                = "fm-${local.facts.bt_country}-${local.facts.bt_tier}-backup-${local.facts.bt_role}2"
  bt_infra_cluster     = local.cluster
  bt_infra_network     = local.network
  os_version           = local.os_version
  cpus                 = "4"
  memory               = "16384"
  lob                  = local.lob
  external_facts       = {
    bt_artemis_primary_members  = ["${local.artemis_primary[0]}.${local.domain}", "${local.artemis_primary[1]}.${local.domain}", "${local.artemis_primary[2]}.${local.domain}", "${local.artemis_primary[3]}.${local.domain}", "${local.artemis_primary[4]}.${local.domain}", "${local.artemis_primary[5]}.${local.domain}"]
    bt_artemis_backup_members   = ["${local.artemis_backup[0]}.${local.domain}", "${local.artemis_backup[1]}.${local.domain}", "${local.artemis_backup[2]}.${local.domain}", "${local.artemis_backup[3]}.${local.domain}", "${local.artemis_backup[4]}.${local.domain}", "${local.artemis_backup[5]}.${local.domain}"]
    bt_product                  = "${local.facts.bt_product}"
    bt_tier                     = "${local.facts.bt_tier}"
    bt_env                      = "${local.facts.bt_env}"
    bt_artemis_version          = "${local.facts.bt_artemis_version}"
    bt_role                     = "${local.facts.bt_role}"
    bt_server_mode              = "backup"
    bt_server_number            = 2
    bt_amq_cluster_name         = "cluster-${local.facts.bt_role}-${local.facts.bt_country}-autolab"
  }
  foreman_hostgroup    = local.facts.bt_foreman_hostgroup
  foreman_environment  = local.environment
  datacenter           = local.facts.bt_datacenter
  additional_disks     = {
    1 = "200",
    2 = "2000",
  }
}

module "artemis_backup_2" {
  source               = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  hostname             = local.artemis_backup[2]
  alias                = "fm-${local.facts.bt_country}-${local.facts.bt_tier}-backup-${local.facts.bt_role}3"
  bt_infra_cluster     = local.cluster
  bt_infra_network     = local.network
  os_version           = local.os_version
  cpus                 = "4"
  memory               = "16384"
  lob                  = local.lob
  external_facts       = {
    bt_artemis_primary_members  = ["${local.artemis_primary[0]}.${local.domain}", "${local.artemis_primary[1]}.${local.domain}", "${local.artemis_primary[2]}.${local.domain}", "${local.artemis_primary[3]}.${local.domain}", "${local.artemis_primary[4]}.${local.domain}", "${local.artemis_primary[5]}.${local.domain}"]
    bt_artemis_backup_members   = ["${local.artemis_backup[0]}.${local.domain}", "${local.artemis_backup[1]}.${local.domain}", "${local.artemis_backup[2]}.${local.domain}", "${local.artemis_backup[3]}.${local.domain}", "${local.artemis_backup[4]}.${local.domain}", "${local.artemis_backup[5]}.${local.domain}"]
    bt_product                  = "${local.facts.bt_product}"
    bt_tier                     = "${local.facts.bt_tier}"
    bt_env                      = "${local.facts.bt_env}"
    bt_artemis_version          = "${local.facts.bt_artemis_version}"
    bt_role                     = "${local.facts.bt_role}"
    bt_server_mode              = "backup"
    bt_server_number            = 3
    bt_amq_cluster_name         = "cluster-${local.facts.bt_role}-${local.facts.bt_country}-autolab"
  }
  foreman_hostgroup    = local.facts.bt_foreman_hostgroup
  foreman_environment  = local.environment
  datacenter           = local.facts.bt_datacenter
  additional_disks     = {
    1 = "200",
    2 = "2000",
  }
}

module "artemis_backup_3" {
  source               = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  hostname             = local.artemis_backup[3]
  alias                = "fm-${local.facts.bt_country}-${local.facts.bt_tier}-backup-${local.facts.bt_role}4"
  bt_infra_cluster     = local.cluster
  bt_infra_network     = local.network
  os_version           = local.os_version
  cpus                 = "4"
  memory               = "16384"
  lob                  = local.lob
  external_facts       = {
    bt_artemis_primary_members  = ["${local.artemis_primary[0]}.${local.domain}", "${local.artemis_primary[1]}.${local.domain}", "${local.artemis_primary[2]}.${local.domain}", "${local.artemis_primary[3]}.${local.domain}", "${local.artemis_primary[4]}.${local.domain}", "${local.artemis_primary[5]}.${local.domain}"]
    bt_artemis_backup_members   = ["${local.artemis_backup[0]}.${local.domain}", "${local.artemis_backup[1]}.${local.domain}", "${local.artemis_backup[2]}.${local.domain}", "${local.artemis_backup[3]}.${local.domain}", "${local.artemis_backup[4]}.${local.domain}", "${local.artemis_backup[5]}.${local.domain}"]
    bt_product                  = "${local.facts.bt_product}"
    bt_tier                     = "${local.facts.bt_tier}"
    bt_env                      = "${local.facts.bt_env}"
    bt_artemis_version          = "${local.facts.bt_artemis_version}"
    bt_role                     = "${local.facts.bt_role}"
    bt_server_mode              = "backup"
    bt_server_number            = 4
    bt_amq_cluster_name         = "cluster-${local.facts.bt_role}-${local.facts.bt_country}-autolab"
  }
  foreman_hostgroup    = local.facts.bt_foreman_hostgroup
  foreman_environment  = local.environment
  datacenter           = local.facts.bt_datacenter
  additional_disks     = {
    1 = "200",
    2 = "2000",
  }
}

module "artemis_backup_4" {
  source               = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  hostname             = local.artemis_backup[4]
  alias                = "fm-${local.facts.bt_country}-${local.facts.bt_tier}-backup-${local.facts.bt_role}5"
  bt_infra_cluster     = local.cluster
  bt_infra_network     = local.network
  os_version           = local.os_version
  cpus                 = "4"
  memory               = "16384"
  lob                  = local.lob
  external_facts       = {
    bt_artemis_primary_members  = ["${local.artemis_primary[0]}.${local.domain}", "${local.artemis_primary[1]}.${local.domain}", "${local.artemis_primary[2]}.${local.domain}", "${local.artemis_primary[3]}.${local.domain}", "${local.artemis_primary[4]}.${local.domain}", "${local.artemis_primary[5]}.${local.domain}"]
    bt_artemis_backup_members   = ["${local.artemis_backup[0]}.${local.domain}", "${local.artemis_backup[1]}.${local.domain}", "${local.artemis_backup[2]}.${local.domain}", "${local.artemis_backup[3]}.${local.domain}", "${local.artemis_backup[4]}.${local.domain}", "${local.artemis_backup[5]}.${local.domain}"]
    bt_product                  = "${local.facts.bt_product}"
    bt_tier                     = "${local.facts.bt_tier}"
    bt_env                      = "${local.facts.bt_env}"
    bt_artemis_version          = "${local.facts.bt_artemis_version}"
    bt_role                     = "${local.facts.bt_role}"
    bt_server_mode              = "backup"
    bt_server_number            = 5
    bt_amq_cluster_name         = "cluster-${local.facts.bt_role}-${local.facts.bt_country}-autolab"
  }
  foreman_hostgroup    = local.facts.bt_foreman_hostgroup
  foreman_environment  = local.environment
  datacenter           = local.facts.bt_datacenter
  additional_disks     = {
    1 = "200",
    2 = "2000",
  }
}

module "artemis_backup_5" {
  source               = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  hostname             = local.artemis_backup[5]
  alias                = "fm-${local.facts.bt_country}-${local.facts.bt_tier}-backup-${local.facts.bt_role}6"
  bt_infra_cluster     = local.cluster
  bt_infra_network     = local.network
  os_version           = local.os_version
  cpus                 = "4"
  memory               = "16384"
  lob                  = local.lob
  external_facts       = {
    bt_artemis_primary_members  = ["${local.artemis_primary[0]}.${local.domain}", "${local.artemis_primary[1]}.${local.domain}", "${local.artemis_primary[2]}.${local.domain}", "${local.artemis_primary[3]}.${local.domain}", "${local.artemis_primary[4]}.${local.domain}", "${local.artemis_primary[5]}.${local.domain}"]
    bt_artemis_backup_members   = ["${local.artemis_backup[0]}.${local.domain}", "${local.artemis_backup[1]}.${local.domain}", "${local.artemis_backup[2]}.${local.domain}", "${local.artemis_backup[3]}.${local.domain}", "${local.artemis_backup[4]}.${local.domain}", "${local.artemis_backup[5]}.${local.domain}"]
    bt_product                  = "${local.facts.bt_product}"
    bt_tier                     = "${local.facts.bt_tier}"
    bt_env                      = "${local.facts.bt_env}"
    bt_artemis_version          = "${local.facts.bt_artemis_version}"
    bt_role                     = "${local.facts.bt_role}"
    bt_server_mode              = "backup"
    bt_server_number            = 6
    bt_amq_cluster_name         = "cluster-${local.facts.bt_role}-${local.facts.bt_country}-autolab"
  }
  foreman_hostgroup    = local.facts.bt_foreman_hostgroup
  foreman_environment  = local.environment
  datacenter           = local.facts.bt_datacenter
  additional_disks     = {
    1 = "200",
    2 = "2000",
  }
}



output "artemis_primary_0" {
  value = {
    "fqdn"  = "${module.artemis_primary_0.fqdn}",
    "alias" = "${module.artemis_primary_0.alias}",
    "ip"    = "${module.artemis_primary_0.ip}",
  }
}

output "artemis_primary_1" {
  value = {
    "fqdn"  = "${module.artemis_primary_1.fqdn}",
    "alias" = "${module.artemis_primary_1.alias}",
    "ip"    = "${module.artemis_primary_1.ip}",
  }
}

output "artemis_primary_2" {
  value = {
    "fqdn"  = "${module.artemis_primary_2.fqdn}",
    "alias" = "${module.artemis_primary_2.alias}",
    "ip"    = "${module.artemis_primary_2.ip}",
  }
}

output "artemis_primary_3" {
  value = {
    "fqdn"  = "${module.artemis_primary_3.fqdn}",
    "alias" = "${module.artemis_primary_3.alias}",
    "ip"    = "${module.artemis_primary_3.ip}",
  }
}

output "artemis_primary_4" {
  value = {
    "fqdn"  = "${module.artemis_primary_4.fqdn}",
    "alias" = "${module.artemis_primary_4.alias}",
    "ip"    = "${module.artemis_primary_4.ip}",
  }
}

output "artemis_primary_5" {
  value = {
    "fqdn"  = "${module.artemis_primary_5.fqdn}",
    "alias" = "${module.artemis_primary_5.alias}",
    "ip"    = "${module.artemis_primary_5.ip}",
  }
}


output "artemis_backup_0" {
  value = {
    "fqdn"  = "${module.artemis_backup_0.fqdn}",
    "alias" = "${module.artemis_backup_0.alias}",
    "ip"    = "${module.artemis_backup_0.ip}",
  }
}

output "artemis_backup_1" {
  value = {
    "fqdn"  = "${module.artemis_backup_1.fqdn}",
    "alias" = "${module.artemis_backup_1.alias}",
    "ip"    = "${module.artemis_backup_1.ip}",
  }
}

output "artemis_backup_2" {
  value = {
    "fqdn"  = "${module.artemis_backup_2.fqdn}",
    "alias" = "${module.artemis_backup_2.alias}",
    "ip"    = "${module.artemis_backup_2.ip}",
  }
}

output "artemis_backup_3" {
  value = {
    "fqdn"  = "${module.artemis_backup_3.fqdn}",
    "alias" = "${module.artemis_backup_3.alias}",
    "ip"    = "${module.artemis_backup_3.ip}",
  }
}

output "artemis_backup_4" {
  value = {
    "fqdn"  = "${module.artemis_backup_4.fqdn}",
    "alias" = "${module.artemis_backup_4.alias}",
    "ip"    = "${module.artemis_backup_4.ip}",
  }
}

output "artemis_backup_5" {
  value = {
    "fqdn"  = "${module.artemis_backup_5.fqdn}",
    "alias" = "${module.artemis_backup_5.alias}",
    "ip"    = "${module.artemis_backup_5.ip}",
  }
}
