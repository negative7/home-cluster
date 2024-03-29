terraform {
  cloud {
    hostname     = "app.terraform.io"
    organization = "negative7"
    workspaces {
      name = "home-cluster-cloudflare"
    }
  }
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "4.26.0"
    }
    http = {
      source  = "hashicorp/http"
      version = "3.4.2"
    }
  }
  required_version = ">= 1.3.0"
}

module "onepassword_item" {
  source = "github.com/bjw-s/terraform-1password-item?ref=main"
  vault  = "home-cluster"
  item   = "cloudflare"
}

data "http" "ipv4_lookup_raw" {
  url = "http://ipv4.icanhazip.com"
}

data "cloudflare_zone" "domain" {
  name = "negative7.com"
}