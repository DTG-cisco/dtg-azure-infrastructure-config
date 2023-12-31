locals {
    env_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))

    subscription_id                        = local.env_vars.locals.subscription_id
    client_id                              = local.env_vars.locals.client_id
    client_secret                          = local.env_vars.locals.client_secret
    tenant_id                              = local.env_vars.locals.tenant_id
    resource_group_name                    = local.env_vars.locals.resource_group_name
    storage_account_name                   = local.env_vars.locals.storage_account_name



     env_tag = "dev"
    // #vnet vars
    // vnet_location = "westeurope"
    // vnet_name = "DTG-vnet"
    // subnet_prefixes = ["10.0.11.0/24"]
}