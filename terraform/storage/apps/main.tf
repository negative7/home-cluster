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
      version = "2.23.0"
    }
    time = {
      source  = "hashicorp/time"
      version = "0.9.1"
    }
  }
  required_version = ">= 1.3.0"
}

module "onepassword_item" {
  source = "github.com/bjw-s/terraform-1password-item?ref=main"
  vault  = "home-cluster"
  item   = "storage"
}