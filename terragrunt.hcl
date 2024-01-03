# https://terragrunt.gruntwork.io/docs/reference/config-blocks-and-attributes/#generate
generate "provider" {
  path      = "provider.tf"
  if_exists = "skip"
  contents  = <<EOF
provider "azurerm" {
    skip_provider_registration = true
    features{
      resource_group {
         prevent_deletion_if_contains_resources = true
      }
  }
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
    subscription_id      = "6169d4a4-b1c8-4c79-b73a-f905fb68b453"
    resource_group_name  = "group"
    storage_account_name = "greenbucket"
    container_name       = "terraform-state"
    key                  = "${path_relative_to_include("site")}/terraform.tfstate"
  }
}