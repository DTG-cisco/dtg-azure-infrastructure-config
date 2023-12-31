locals {
  env_vars = read_terragrunt_config("env.hcl")
  #

  subscription_id                        = local.env_vars.locals.subscription_id
  client_id                              = local.env_vars.locals.client_id
  client_secret                          = local.env_vars.locals.client_secret
  tenant_id                              = local.env_vars.locals.tenant_id
  resource_group_name                    = local.env_vars.locals.resource_group_name
  storage_account_name                   = local.env_vars.locals.storage_account_name
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "azurerm" {
    skip_provider_registration = true
    features{}
}
EOF
}

remote_state {
  backend = "azurerm"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }
  config = {
    subscription_id      = local.subscription_id
    resource_group_name  = local.resource_group_name
    storage_account_name = local.storage_account_name
    container_name       = "terraform-state"
    key                  = "${path_relative_to_include("site")}/terraform.tfstate"
  }
}