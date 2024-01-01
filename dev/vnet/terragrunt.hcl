# --------- VPC Azure -------------
#
# https://registry.terraform.io/modules/Azure/vnet/azurerm/latest
#
include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "tfr:///Azure/vnet/azurerm?version=4.1.0"
}

locals {
  env_vars            = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  resource_group_name = local.env_vars.locals.resource_group_name

  vnet_location   = local.env_vars.locals.region
  env_tag         = local.env_vars.locals.env_tag
  subnet_prefixes = local.env_vars.locals.subnet_prefixes
  subnet_names    = local.env_vars.locals.subnet_names
}

inputs = {
  resource_group_name = "${local.resource_group_name}"
  use_for_each        = true
  vnet_location       = "${local.vnet_location}"
  vnet_name           = "vnet-${local.env_tag}"
  subnet_names        = local.subnet_names
  subnet_prefixes     = local.subnet_prefixes
}