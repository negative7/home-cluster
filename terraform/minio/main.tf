terraform {

  # backend "remote" {
  #   organization = "negative7"
  #   workspaces {
  #     name = "home-minio"
  #   }
  # }

  required_providers {
    minio = {
      source  = "refaktory/minio"
      version = "0.1.0"
    }
    sops = {
      source  = "carlpett/sops"
      version = "0.7.2"
    }
  }
}

data "sops_file" "minio_secrets" {
  source_file = "secret.sops.yaml"
}

provider "minio" {
  endpoint   = data.sops_file.minio_secrets.data["minio_endpoint"]
  access_key = data.sops_file.minio_secrets.data["minio_root_user"]
  secret_key = data.sops_file.minio_secrets.data["minio_root_password"]
  ssl        = false
}

locals {
  bucket_settings = {
    "k3s"      = { versioning_enabled = false },
    "loki"     = { versioning_enabled = false },
    "thanos"   = { versioning_enabled = false },
    "longhorn" = { versioning_enabled = false },
    "k10"      = { versioning_enabled = false }
  }
}

resource "minio_bucket" "map" {
  for_each = local.bucket_settings

  name               = each.key
  versioning_enabled = each.value.versioning_enabled
}
