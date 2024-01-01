Terragrunt Infrastructure for Azure cloud

### Description 
This repository houses infrastructure configurations managed with Terragrunt. 
It uses imported Azure Terraform modules structured for managing resources across multiple environments 
using Terragrunt's DRY (Don't Repeat Yourself) principles. 
The setup enables streamlined provisioning and management of cloud resources while
maintaining consistency and reusability across different environments.

---------------------------

### Prerequisites
#### Before proceeding, ensure the following software is installed:

- [Terragrunt](https://terragrunt.gruntwork.io/docs/getting-started/install/) 
- [Terraform](https://developer.hashicorp.com/terraform/install)


#### How to use credentials
[Set Env vars](https://learn.microsoft.com/en-us/azure/developer/terraform/get-started-cloud-shell-powershell?tabs=bash#specify-service-principal-credentials-in-environment-variables)

```
export ARM_SUBSCRIPTION_ID="<azure_subscription_id>"
export ARM_TENANT_ID="<azure_subscription_tenant_id>"
export ARM_CLIENT_ID="<service_principal_appid>"
export ARM_CLIENT_SECRET="<service_principal_password>"
```

### Select needed region to locate [Azure Regions](https://github.com/claranet/terraform-azurerm-regions/blob/master/REGIONS.md)