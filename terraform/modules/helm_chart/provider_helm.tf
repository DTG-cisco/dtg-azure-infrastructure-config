provider "helm" {
  kubernetes {
    host                   = var.kuber_host
    cluster_ca_certificate = base64decode(var.cluster_ca_certificate)
    token                  = var.password
  }
}
