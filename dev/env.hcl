locals {
  env_tag             = "dev"
  resource_group_name = "group"
  region              = "eastasia"
  subnet_prefixes     = ["10.0.11.0/24"]
  subnet_names        = ["dev-subnet-1"]

  # Helm Consul Variables
  namespace         = "consul"
  repo_consul       = "https://helm.releases.hashicorp.com"
  chart_name_consul = "consul"
  app_consul = {
    name             = "consul"
    deploy           = 1
    chart            = "consul"
    wait             = false
    recreate_pods    = false
    version          = "1.3.0"
    create_namespace = true
  }

  # Variables For  Frontend App (helm)
  namespace_app = "app"
  repo_front    = "https://dtg-cisco.github.io/helm-charts/"
  chart_front   = "frontend"
  frontend_image_name = "nexus.green-team-schedule.pp.ua/frontend"
  frontend_image_tag  = "1.0.1"

  app_front = {
    name             = "app-front"
    deploy           = 1
    chart            = "frontend"
    wait             = false
    recreate_pods    = false
    version          = "0.1.3"
    create_namespace = true
  }


  # For Backend App (helm)
  repo_back          = "https://dtg-cisco.github.io/helm-charts/"
  chart_back         = "backend"
  backend_image_name = "nexus.green-team-schedule.pp.ua/backend"
  backend_image_tag  = "1.0.0"
  app_back = {
    name             = "app-back"
    deploy           = 1
    chart            = "backend"
    wait             = false
    recreate_pods    = false
    version          = "0.1.2"
    create_namespace = true
  }
}