provider "kubernetes" {
  host                   = "https://10.0.1.10:6443"
  client_certificate     = base64decode(data.sops_file.secrets.data["client_certificate"])
  client_key             = base64decode(data.sops_file.secrets.data["client_key"])
  cluster_ca_certificate = base64decode(data.sops_file.secrets.data["cluster_ca_certificate"])
}