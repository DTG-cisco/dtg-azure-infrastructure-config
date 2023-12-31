include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "tfr:///Azure/aks/azurerm?version=7.5.0"
}

locals {
    env_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))

    env_tag = local.env_vars.locals.env_tag
    resource_group_name = local.env_vars.locals.resource_group_name
}



inputs = {
  prefix                            = "${local.env_tag}"
  resource_group_name               = "${local.resource_group_name}"
  azure_policy_enabled              = true
  cluster_name                      = "${local.env_tag}-schedule"
  public_network_access_enabled     = false
  identity_type                     = "SystemAssigned"
  //net_profile_pod_cidr              = "10.1.0.0/16" # Override at the environment
  private_cluster_enabled           = true
  rbac_aad                          = true
  rbac_aad_managed                  = true
  role_based_access_control_enabled = true
}