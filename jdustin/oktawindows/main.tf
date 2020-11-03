terraform {
 backend "s3" {}
}

locals {
    facts = {
        "bt_tier" = "dev"
        "bt_env" = "1",
        "bt_product" = "cloud"
        "bt_role" = "base"
    }
    cluster = "ny2-aza-ntnx-13"
    network = "ny2-autolab-app-ahv"
    os      = "win2019"
    cpus    = "2"
    memory  = "8192"
    additional_disks = {
        1 = "50"
    }
    environment = "Master"
    hostgroup   = "BT Base Windows Server"
    datacenter  = "ny2"
    lob         = "CLOUD"
}

module "us01vwoktatest1" {
    source              = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
    hostname            = "us01vwoktatest1"
    alias               = "cloud-oktatest1"
    bt_infra_cluster    = local.cluster
    bt_infra_network    = local.network
    os_version          = local.os
    cpus                = local.cpus
    memory              = local.memory
    external_facts      = local.facts
    foreman_environment = local.environment
    additional_disks    = local.additional_disks
    foreman_hostgroup   = local.hostgroup
    datacenter          = local.datacenter
    lob                 = local.lob
}

output "us01vwoktatest1" {
 value = {
 "fqdn" = "${module.us01vwoktatest1.fqdn}",
 "alias" = "${module.us01vwoktatest1.alias}",
 "ip" = "${module.us01vwoktatest1.ip}",
 }
}
