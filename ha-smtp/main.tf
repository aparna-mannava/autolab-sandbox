terraform {
  backend "s3" {}
}

locals {
  product     = "inf"
  datacenter  = "ny2"
  lob         = "CLOUD"
  facts       = {
    "bt_product" = "inf",
  }

  smtp_lb01 = {
    hostname  = "us01vlsmtplb01"
    alias     = "${local.product}-${local.datacenter}-smtplb01a"
    hostgroup = "BT SMTP LB Server"
    cpu       = "2"
    memory    = "8192"
    os        = "rhel8"
    cluster   = "ny2-aze-ntnx-12"
    network   = "ny2-autolab-app-ahv"
    facts     = merge(local.facts, { "bt_tier" = "autolab"})
    environment = "feature_CLOUD_108232"
  }

  smtp_lb02 = {
    hostname  = "us01vlsmtplb02"
    alias     = "${local.product}-${local.datacenter}-smtplb01b"
    hostgroup = "BT SMTP LB Server"
    cpu       = "2"
    memory    = "8192"
    os        = "rhel8"
    cluster   = "ny2-aze-ntnx-12"
    network   = "ny2-autolab-app-ahv"
    facts     = merge(local.facts, { "bt_tier" = "autolab"})
    environment = "feature_CLOUD_108232"
  }

  smtp_m01 = {
    hostname  = "us01vlsmtpm01"
    alias     = "${local.product}-${local.datacenter}-smtpm01"
    hostgroup = "BT SMTP Cluster Servers"
    cpu       = "2"
    memory    = "8192"
    os        = "rhel7"
    cluster   = "ny2-aze-ntnx-12"
    network   = "ny2-autolab-app-ahv"
    facts     = merge(local.facts, { "bt_tier" = "autolab"})
    environment = "feature_CLOUD_104536_00"
  }

  smtp_m02 = {
    hostname  = "us01vlsmtpm02"
    alias     = "${local.product}-${local.datacenter}-smtpm02"
    hostgroup = "BT SMTP Cluster Servers"
    cpu       = "2"
    memory    = "8192"
    os        = "rhel7"
    cluster   = "ny2-aze-ntnx-12"
    network   = "ny2-autolab-app-ahv"
    facts     = merge(local.facts, { "bt_tier" = "autolab"})
    environment = "feature_CLOUD_104536_00"
  }

  smtp_m03 = {
    hostname  = "us01vlsmtpm03"
    alias     = "${local.product}-${local.datacenter}-smtpm03"
    hostgroup = "BT SMTP Cluster Servers"
    cpu       = "2"
    memory    = "8192"
    os        = "rhel7"
    cluster   = "ny2-aze-ntnx-12"
    network   = "ny2-autolab-app-ahv"
    facts     = merge(local.facts, { "bt_tier" = "autolab"})
    environment = "feature_CLOUD_104536_00"
  }
}

module "smtp_lb01" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = local.smtp_lb01.hostname
  alias                = local.smtp_lb01.alias
  bt_infra_cluster     = local.smtp_lb01.cluster
  bt_infra_network     = local.smtp_lb01.network
  os_version           = local.smtp_lb01.os
  cpus                 = local.smtp_lb01.cpu
  memory               = local.smtp_lb01.memory
  external_facts       = local.smtp_lb01.facts
  lob                  = local.lob
  foreman_environment  = local.environment
  foreman_hostgroup    = local.smtp_lb01.hostgroup
  datacenter           = local.datacenter
  additional_disks     = {
    1 = "100",
  }
}

module "smtp_lb02" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = local.smtp_lb02.hostname
  alias                = local.smtp_lb02.alias
  bt_infra_cluster     = local.smtp_lb02.cluster
  bt_infra_network     = local.smtp_lb02.network
  os_version           = local.smtp_lb02.os
  cpus                 = local.smtp_lb02.cpu
  memory               = local.smtp_lb02.memory
  external_facts       = local.smtp_lb02.facts
  lob                  = local.lob
  foreman_environment  = local.environment
  foreman_hostgroup    = local.smtp_lb02.hostgroup
  datacenter           = local.datacenter
  additional_disks     = {
    1 = "100",
  }
}

module "smtp_m01" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = local.smtp_m01.hostname
  alias                = local.smtp_m01.alias
  bt_infra_cluster     = local.smtp_m01.cluster
  bt_infra_network     = local.smtp_m01.network
  os_version           = local.smtp_m01.os
  cpus                 = local.smtp_m01.cpu
  memory               = local.smtp_m01.memory
  external_facts       = local.smtp_m01.facts
  lob                  = local.lob
  foreman_environment  = local.environment
  foreman_hostgroup    = local.smtp_m01.hostgroup
  datacenter           = local.datacenter
  additional_disks     = {
    1 = "200",
  }
}

module "smtp_m02" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = local.smtp_m02.hostname
  alias                = local.smtp_m02.alias
  bt_infra_cluster     = local.smtp_m02.cluster
  bt_infra_network     = local.smtp_m02.network
  os_version           = local.smtp_m02.os
  cpus                 = local.smtp_m02.cpu
  memory               = local.smtp_m02.memory
  external_facts       = local.smtp_m02.facts
  lob                  = local.lob
  foreman_environment  = local.environment
  foreman_hostgroup    = local.smtp_m02.hostgroup
  datacenter           = local.datacenter
  additional_disks     = {
    1 = "200",
  }
}

module "smtp_m03" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = local.smtp_m03.hostname
  alias                = local.smtp_m03.alias
  bt_infra_cluster     = local.smtp_m03.cluster
  bt_infra_network     = local.smtp_m03.network
  os_version           = local.smtp_m03.os
  cpus                 = local.smtp_m03.cpu
  memory               = local.smtp_m03.memory
  external_facts       = local.smtp_m03.facts
  lob                  = local.lob
  foreman_environment  = local.environment
  foreman_hostgroup    = local.smtp_m03.hostgroup
  datacenter           = local.datacenter
  additional_disks     = {
    1 = "200",
  }
}

output "smtp_lb01" {
  value = {
    "fqdn"  = module.smtp_lb01.fqdn,
    "alias" = module.smtp_lb01.alias,
    "ip"    = module.smtp_lb01.ip,
  }
}

output "smtp_lb02" {
  value = {
    "fqdn"  = module.smtp_lb02.fqdn,
    "alias" = module.smtp_lb02.alias,
    "ip"    = module.smtp_lb02.ip,
  }
}

output "smtp_m01" {
  value = {
    "fqdn"  = module.smtp_m01.fqdn,
    "alias" = module.smtp_m01.alias,
    "ip"    = module.smtp_m01.ip,
  }
}

output "smtp_m02" {
  value = {
    "fqdn"  = module.smtp_m02.fqdn,
    "alias" = module.smtp_m02.alias,
    "ip"    = module.smtp_m02.ip,
  }
}

output "smtp_m01" {
  value = {
    "fqdn"  = module.smtp_m03.fqdn,
    "alias" = module.smtp_m03.alias,
    "ip"    = module.smtp_m03.ip,
  }
}