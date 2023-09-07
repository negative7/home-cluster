resource "cloudflare_record" "apex" {
  name    = "ipv4"
  zone_id = data.cloudflare_zone.domain.id
  value   = chomp(data.http.ipv4_lookup_raw.response_body)
  proxied = true
  type    = "A"
  ttl     = 1
}

resource "cloudflare_record" "root" {
  name    = "negative7.com"
  zone_id = data.cloudflare_zone.domain.id
  value   = "ipv4.negative7.com"
  proxied = true
  type    = "CNAME"
  ttl     = 1
}

resource "cloudflare_record" "home_cname" {
  name    = module.onepassword_item.fields["cname-wan-ip"]
  zone_id = data.cloudflare_zone.domain.id
  value   = "ipv4.negative7.com"
  proxied = false
  type    = "CNAME"
  ttl     = 1
}