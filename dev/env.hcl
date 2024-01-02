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

}