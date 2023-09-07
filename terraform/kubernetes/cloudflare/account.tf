resource "cloudflare_account" "main" {
  name              = "Admin@negative7.com"
  type              = "standard"
  enforce_twofactor = false
}