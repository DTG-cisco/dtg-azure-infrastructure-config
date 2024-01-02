## Here are common problems with Azure Terragrunt Modules:

-----------------------
### Azure Helm Module
reason: need to create new filename for provider.tf (conflicts with already present helm charts)

[aks-helm/azure](https://registry.terraform.io/modules/cloudopsworks/aks-helm/azure/latest?tab=inputs)
  source = "tfr:///cloudopsworks/aks-helm/azure?version=1.0.1"


```terraform
generate "provider" {
  path = "provider-azure.tf"
}
```

Helm Module needed in provider (but conflict in VPC)
```terraform

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.85.0"
    }
  }
}
```
How to fix: need to create own module

-----------------------
### Azure Kubernetes Module
[aks/azurerm](https://registry.terraform.io/modules/Azure/aks/azurerm/latest)
output "password"  - No any data, (need to use admin_password)<br>
Other problem: in different Kubernetes cluster configs, available different variables with passwords (admin_password, password)
```terraform
output "password" {
  description = "The `password` in the `azurerm_kubernetes_cluster`'s `kube_config` block. A password or token used to authenticate to the Kubernetes cluster."
  sensitive   = true
  value       = azurerm_kubernetes_cluster.main.kube_config[0].password
}
```
```terraform
output "host" {
  description = "The `host` in the `azurerm_kubernetes_cluster`'s `kube_config` block. The Kubernetes cluster server host."
  sensitive   = true
  example     = https://dev-add2g43.eastazia.azmk8s.io:443
}
```
how it was tested (in any default resource create tags: 
```terraform
  tags = {
    "host" : dependency.cluster_ip.outputs.host,
    "passw" : dependency.cluster_ip.outputs.password
    "admin_passw" : dependency.cluster_ip.outputs.admin_password
  }
```