# --------- Kubernetes Cluster Azure -------------
#
# https://registry.terraform.io/modules/Azure/aks/azurerm/latest
#
include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "tfr:///Azure/aks/azurerm?version=7.5.0"
}

locals {
  env_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))

  env_tag             = local.env_vars.locals.env_tag
  resource_group_name = local.env_vars.locals.resource_group_name
}



inputs = {
  agents_count                  = 2 # The number of Nodes  (Default: 2)
#  agents_size =  "Standard_D2s_v3" # node type; Default: "Standard_D2s_v3"
  prefix                        = "${local.env_tag}"
  resource_group_name           = "${local.resource_group_name}"
  cluster_name                  = "${local.env_tag}-cluster"
  public_network_access_enabled = true # Default: true Whether public network access is allowed for this Kubernetes Cluster.
#  identity_type                 = "SystemAssigned"
  net_profile_pod_cidr              = "10.1.0.0/16" # Override at the environment
  private_cluster_enabled           = false # Description: If true cluster API server will be exposed only on internal IP address and available only in cluster vnet.
  rbac_aad                          = false # Default
  rbac_aad_managed                  = false
  role_based_access_control_enabled = true
}