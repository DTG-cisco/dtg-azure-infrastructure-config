// include "root" {
//     path = find_in_parent_folders()
// }

// terraform {
//     source = "tfr:///Azure/postgresql/azurerm?version=3.1.1"
// }

// dependency "vnet" {
//     config_path                             = "../vnet"
//     mock_outputs_allowed_terraform_commands = ["init", "validate", "plan", "destroy"]
//     mock_outputs = {

//     }
// }

// locals {
//     env_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))


// }

// inputs = {
//     administrator_login = ""
//     administrator_password = ""
//     location = ""
//     resource_group_name = ""
//     server_name = ""
//     storage_mb = 5120

// }