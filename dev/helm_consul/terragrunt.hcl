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


locals {
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  env              = local.environment_vars.locals.env_tag
  app              = local.environment_vars.locals.app_consul
  namespace        = local.environment_vars.locals.namespace
  chart_n          = local.environment_vars.locals.chart_name_consul
  repository       = local.environment_vars.locals.repo_consul
}


inputs = {
  values                 = ["${file("values/consul-values.yaml")}"]
  env                    = local.env
  zone                   = "local.zone"
  namespace              = local.namespace
  chart_name             = local.chart_n
  repository             = local.repository
  kuber_host             = dependency.cluster_ip.outputs.host
  cluster_ca_certificate = dependency.cluster_ip.outputs.cluster_ca_certificate
  password               = dependency.cluster_ip.outputs.password

  app = local.app
}
