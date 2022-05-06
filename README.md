# Terraform Automation Sandbox

# <span style="color:red">This repo has been migrated to Corporate Bitbucket: </span>[https://bitbucket.bottomline.tech/projects/TER/repos/autolab-sandbox](https://bitbucket.bottomline.tech/projects/TER/repos/autolab-sandbox/)

## Repo Description
This repository is for Terraform code for building sandbox automation lab servers.
This repository is **shared**, and resources built within it are deleted at a regular
cadence.

**Currently, all resources built within this repository are deleted monthly on the
first of the month.**

## Repo Usage
Note - builds in this repo need to use one opf the enabled Nutanix cluster in NY2.  At this time, this
is **ny2-aze-ntnx-11** however this does change.  Check the 
[BT Terraform Infrastructure Module README](https://us-pr-stash.saas-p.com/projects/TRRFRM/repos/terraform-module-infrastructure/browse)
for the latest information about what Nutanix clusters are currently enabled in NY2.

Since this is a shared repository, you must create a directory with your unix login/username.
Within that directory, you can create subdirectories for any Atlantis projects you wish
to build.

Example:
```
username/
|
|> project1/
|    main.tf
|
|> project2/
|    main.tf
|
|> lab1/
|    main.tf
```

Each new environment that you add must be added to the top level `atlantis.yaml` file as well,
so that it will be treated as an Atlantis project.

## Code Example
This example deploys a single RHEL 7 server in the Autolab, with 1 additional disk and an
additional `bt_tier` facter fact.

```hcl
terraform {
  backend "http" {}
}
module "app_server_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlsndbxdmo1"
  bt_infra_cluster     = "ny2-aze-ntnx-11"
  bt_infra_network     = "ny2-autolab-app-ahv"
  os_version           = "rhel7"
  foreman_environment  = "master"
  foreman_hostgroup    = "BT Base Server"
  datacenter           = "ny2"
  lob                  = "YOUR LINE OF BUSINESS" # Replace this with your own line of business
  additional_disks     = {
    1 = "20"
  }
  external_facts       = {
    "bt_tier" = "dev"
  }
}

output "app_server_1" {
  value = {
    "fqdn"  = "${module.app_server_1.fqdn}",
    "alias" = "${module.app_server_1.alias}",
    "ip"    = "${module.app_server_1.ip}",
  }
}
```

## Additional Information

Note that you are responsible for locating a valid available hostname or hostnames to use in your code.  There is a hostname generation utility available [Hostname Gen](https://us-pr-stash.saas-p.com/projects/INFAPP/repos/hostgen/browse).

Please see [Terraform Documentation on the Wiki](https://confluence.bottomline.tech/display/CEA/Terraform) for additional information about using Terraform.
