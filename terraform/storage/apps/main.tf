terraform {
  cloud {
    hostname     = "app.terraform.io"
    organization = "negative7"
    workspaces {
      name = "home-cluster-storage"
    }
  }
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.27.0"
    }
    sops = {
      source  = "carlpett/sops"
      version = "1.0.0"
    }
    time = {
      source  = "hashicorp/time"
      version = "0.10.0"
    }
  }
  required_version = ">= 1.3.0"

}

data "sops_file" "secrets" {
  source_file = "secret.sops.yaml"
}