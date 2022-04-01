# Obtain current home IP address
data "http" "ipv4" {
  url = "http://ipv4.icanhazip.com"
}

#
# Base records
#

# Record which will be updated by DDNS
resource "cloudflare_record" "apex_ipv4" {
  name    = "ipv4"
  zone_id = lookup(data.cloudflare_zones.domain.zones[0], "id")
  value   = chomp(data.http.ipv4.body)
  proxied = true
  type    = "A"
  ttl     = 1
}

resource "cloudflare_record" "cname_root" {
  name    = data.sops_file.cloudflare_secrets.data["cloudflare_domain"]
  zone_id = lookup(data.cloudflare_zones.domain.zones[0], "id")
  value   = "ipv4.${data.sops_file.cloudflare_secrets.data["cloudflare_domain"]}"
  proxied = true
  type    = "CNAME"
  ttl     = 1
}

resource "cloudflare_record" "cname_www" {
  name    = "www"
  zone_id = lookup(data.cloudflare_zones.domain.zones[0], "id")
  value   = "ipv4.${data.sops_file.cloudflare_secrets.data["cloudflare_domain"]}"
  proxied = true
  type    = "CNAME"
  ttl     = 1
}

resource "cloudflare_record" "cname_wireguard" {
  name    = "wg1"
  zone_id = lookup(data.cloudflare_zones.domain.zones[0], "id")
  value   = "ipv4.${data.sops_file.cloudflare_secrets.data["cloudflare_domain"]}"
  proxied = false
  type    = "CNAME"
  ttl     = 1
}

#
# Google
#

resource "cloudflare_record" "cname_google" {
  name    = "mail"
  zone_id = lookup(data.cloudflare_zones.domain.zones[0], "id")
  value   = "ghs.google.com"
  proxied = false
  type    = "CNAME"
  ttl     = 1
}

resource "cloudflare_record" "mx_google_a" {
  name     = data.sops_file.cloudflare_secrets.data["cloudflare_domain"]
  zone_id  = lookup(data.cloudflare_zones.domain.zones[0], "id")
  value    = "aspmx.l.google.com"
  proxied  = false
  type     = "MX"
  ttl      = 1
  priority = 10
}

resource "cloudflare_record" "mx_google_b" {
  name     = data.sops_file.cloudflare_secrets.data["cloudflare_domain"]
  zone_id  = lookup(data.cloudflare_zones.domain.zones[0], "id")
  value    = "alt2.aspmx.l.google.com"
  proxied  = false
  type     = "MX"
  ttl      = 1
  priority = 20
}

resource "cloudflare_record" "mx_google_c" {
  name     = data.sops_file.cloudflare_secrets.data["cloudflare_domain"]
  zone_id  = lookup(data.cloudflare_zones.domain.zones[0], "id")
  value    = "aspmx2.googlemail.com"
  proxied  = false
  type     = "MX"
  ttl      = 1
  priority = 30
}

resource "cloudflare_record" "mx_google_d" {
  name     = data.sops_file.cloudflare_secrets.data["cloudflare_domain"]
  zone_id  = lookup(data.cloudflare_zones.domain.zones[0], "id")
  value    = "alt1.aspmx.l.google.com"
  proxied  = false
  type     = "MX"
  ttl      = 1
  priority = 20
}

resource "cloudflare_record" "mx_google_e" {
  name     = data.sops_file.cloudflare_secrets.data["cloudflare_domain"]
  zone_id  = lookup(data.cloudflare_zones.domain.zones[0], "id")
  value    = "aspmx5.googlemail.com"
  proxied  = false
  type     = "MX"
  ttl      = 1
  priority = 30
}

resource "cloudflare_record" "mx_google_f" {
  name     = data.sops_file.cloudflare_secrets.data["cloudflare_domain"]
  zone_id  = lookup(data.cloudflare_zones.domain.zones[0], "id")
  value    = "aspmx3.googlemail.com"
  proxied  = false
  type     = "MX"
  ttl      = 1
  priority = 30
}

resource "cloudflare_record" "mx_google_g" {
  name     = data.sops_file.cloudflare_secrets.data["cloudflare_domain"]
  zone_id  = lookup(data.cloudflare_zones.domain.zones[0], "id")
  value    = "aspmx4.googlemail.com"
  proxied  = false
  type     = "MX"
  ttl      = 1
  priority = 30
}

resource "cloudflare_record" "txt_google_verification" {
  name    = data.sops_file.cloudflare_secrets.data["cloudflare_domain"]
  zone_id = lookup(data.cloudflare_zones.domain.zones[0], "id")
  value   = "google-site-verification=1uCIWb0gx9kAB-2xH3PRU_vQ-q-N6XGqJGeYBruNdoQ"
  proxied = false
  type    = "TXT"
  ttl     = 1
}

#
# Mailgun
#

resource "cloudflare_record" "txt_mailun" {
  name    = data.sops_file.cloudflare_secrets.data["cloudflare_domain"]
  zone_id = lookup(data.cloudflare_zones.domain.zones[0], "id")
  value   = "v=spf1 include:mailgun.org ~all"
  proxied = false
  type    = "TXT"
  ttl     = 1
}

resource "cloudflare_record" "txt__domainkey" {
  name    = "k1._domainkey.${data.sops_file.cloudflare_secrets.data["cloudflare_domain"]}"
  zone_id = lookup(data.cloudflare_zones.domain.zones[0], "id")
  value   = "k=rsa; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDQy4IgP8LrOHAyWMdiEY2aQrRrapGMs7gLsZYdIc+SaJl0UrGksst58+a+lxn8iZ7wwnP/y4tRVvxvjZiUANh278izKSa4SPQ6Qsmev5UaU0x2ziQfCV/wkBdmgSwkMO5gph2wblbsppgOiQsgeZ2fn5kl/SaKitK2RVa21Fm/awIDAQAB"
  proxied = false
  type    = "TXT"
  ttl     = 1
}


#
# Additional email records
#

resource "cloudflare_record" "txt_dmarc" {
  name    = "_dmarc"
  zone_id = lookup(data.cloudflare_zones.domain.zones[0], "id")
  value   = "v=DMARC1; p=none; rua=mailto:${data.sops_file.cloudflare_secrets.data["cloudflare_email"]}"
  proxied = false
  type    = "TXT"
  ttl     = 1
}
