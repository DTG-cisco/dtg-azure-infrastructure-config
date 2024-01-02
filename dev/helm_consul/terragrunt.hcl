terraform {
  source = "git::https://github.com/DTG-cisco/dtg-azure-infrastructure-config.git//terraform/modules/helm_chart?ref=dev-test"
}

dependencies {
  paths = ["../kubernetes"]
}

dependency "cluster_ip" {
  # Cluster OutPuts here: https://registry.terraform.io/modules/Azure/aks/azurerm/latest?tab=outputs
  config_path                             = "../kubernetes"
  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan", "destroy"]

  mock_outputs = {
    host                   = "10.10.10.10"
    admin_password         = "mock"
    cluster_ca_certificate = "mock"
  }
}

/*
# for now they are hardcoded
locals {
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  env              = local.environment_vars.locals.environment
  app              = local.environment_vars.locals.app_api_gw
  namespace        = local.environment_vars.locals.namespace
  chart_n          = local.environment_vars.locals.chart_api_gw
  repository       = local.environment_vars.locals.repo_api_gw
  zone             = local.environment_vars.locals.zone
}
*/


inputs = {
  values                 = ["${file("values/consul-values.yaml")}"]
  env                    = dependency.cluster_ip.outputs.aks_name
  zone                   = "local.zone"
  namespace              = "consul"
  chart_name             = "consul"
  repository             = "https://helm.releases.hashicorp.com"
  kuber_host             = dependency.cluster_ip.outputs.host
  cluster_ca_certificate = dependency.cluster_ip.outputs.cluster_ca_certificate
  password               = dependency.cluster_ip.outputs.admin_password

  app = {
    name             = "consul"
    deploy           = 1
    chart            = "consul"
    wait             = false
    recreate_pods    = false
    version          = "1.3.0"
    create_namespace = true
  }

}
