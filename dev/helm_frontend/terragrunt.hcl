# Install Frontend via Helm Chart Repo
terraform {
  source = "git::https://github.com/DTG-cisco/dtg-azure-infrastructure-config.git//terraform/modules/helm_chart"
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
  app              = local.environment_vars.locals.app_front
  namespace        = local.environment_vars.locals.namespace
  chart_n          = local.environment_vars.locals.chart_front
  repository       = local.environment_vars.locals.repo_front
  fe_img_name      = local.environment_vars.locals.frontend_image_name
  fe_img_tag       = local.environment_vars.locals.frontend_image_tag
}


inputs = {
  env                    = local.env
  zone                   = "local.zone"
  namespace              = local.namespace
  chart_name             = local.chart_n
  repository             = local.repository
  kuber_host             = dependency.cluster_ip.outputs.host
  cluster_ca_certificate = dependency.cluster_ip.outputs.cluster_ca_certificate
  password               = dependency.cluster_ip.outputs.password

  app = local.app

  set = [
    #    https://github.com/terraform-module/terraform-helm-release
    {
      name  = "service.name"
      value = "frontend"
    },
    {
      name  = "namespace"
      value = "${local.namespace}"
    },
    {
      name  = "frontend_image.name"
      value = get_env("IMAGE_NAME", "${local.fe_img_name}")
    },
    {
      name  = "frontend_image.tag"
      value = get_env("FR_IMAGE_DEV_TAG", "${local.fe_img_tag}")
    },
  ]
}
