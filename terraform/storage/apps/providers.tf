provider "kubernetes" {
  host                   = "https://10.0.1.10:6443"
  client_certificate     = module.onepassword_item.fields["client_certificate"]
  client_key             = module.onepassword_item.fields["client_key"]
  cluster_ca_certificate = module.onepassword_item.fields["cluster_ca_certificate"]
}