terraform {
 backend "s3" {}
}

locals {
    product = "ux"
    facts = {
        "bt_tier" = "dev"
        "bt_env" = "1",
        "bt_product" = "glu"
        "bt_role" = "jenkins"
    }
    cluster = "ny2-aza-ntnx-05"
    network = "ny2-autolab-app-ahv"
    os      = "rhel8"
    cpus    = "8"
    memory  = "8192"
    additional_disks = {
        1 = "500"
    }
    environment = "feature_GLU_3502"
    hostgroup   = "UX Jenkins"
    datacenter  = "ny2"
    lob         = "CLOUD"
}

module "jenkins" {
    source              = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
    hostname            = "us01vlglujen006"
    alias               = "glu-${local.facts.bt_tier}-backup-jenkins"
    bt_infra_cluster    = local.cluster
    bt_infra_network    = local.network
    os_version          = local.os
    cpus                = local.cpus
    memory              = local.memory
    external_facts      = local.facts
    foreman_environment = local.environment
    foreman_hostgroup   = local.hostgroup
    datacenter          = local.datacenter
    lob                 = local.lob
}

output "jenkins" {
 value = {
 "fqdn" = "${module.jenkins.fqdn}",
 "alias" = "${module.jenkins.alias}",
 "ip" = "${module.jenkins.ip}",
 }
}
