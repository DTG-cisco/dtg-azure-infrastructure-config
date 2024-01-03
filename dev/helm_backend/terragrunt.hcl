# Install Backend via Helm Chart Repo
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
  app              = local.environment_vars.locals.app_back
  namespace        = local.environment_vars.locals.namespace
  chart_n          = local.environment_vars.locals.chart_back
  repository       = local.environment_vars.locals.repo_back
  be_img_name      = local.environment_vars.locals.backend_image_name
  be_img_tag       = local.environment_vars.locals.backend_image_tag
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
      value = "backend"
    },
    {
      name  = "namespace"
      value = "${local.namespace}"
    },
    {
      name  = "backend_image.name"
      value = get_env("IMAGE_NAME", "${local.be_img_name}")
    },
    {
      name  = "backend_image.tag"
      value = get_env("BE_IMAGE_DEV_TAG", "${local.be_img_tag}")
    },
    {
      name  = "postgres.db_user"
      value = "schedule"
    },
    {
      name  = "postgres.db_host"
      value = "localhost"
    },
    {
      name  = "mongodb.host"
      value = "localhost"
    }
  ]

  set_sensitive = [
    # Kubernetes Secret Will be created via charts/backend/template/secret.yaml
    {
      path  = "nexus.token"
      value = "eyJhdXRocyI6eyJodHRwczovL25leHVzLmdyZWVuLXRlYW0tc2NoZWR1bGUucHAudWEiOnsidXNlcm5hbWUiOiJhZG1pbiIsInBhc3N3b3JkIjoic3Vzc1lhbW9nMTFzIiwiYXV0aCI6IllXUnRhVzQ2YzNWemMxbGhiVzluTVRGeiJ9fX0="
    },
    {
      path  = "postgres.db_password"
      value = "pass"
    }
  ]
}
