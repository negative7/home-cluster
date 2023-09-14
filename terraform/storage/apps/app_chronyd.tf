resource "kubernetes_daemon_set_v1" "chronyd" {
  metadata {
    name      = "chronyd"
    namespace = "default"
    labels = {
      "app.arpa.home/name" = "chronyd"
    }
  }
  spec {
    selector {
      match_labels = {
        "app.arpa.home/name" = "chronyd"
      }
    }
    template {
      metadata {
        labels = {
          "app.arpa.home/name" = "chronyd"
        }
      }
      spec {
        container {
          name              = "ntp"
          image             = "docker.io/simonrupf/chronyd:0.4.3"
          image_pull_policy = "IfNotPresent"
          port {
            name           = "ntp"
            container_port = 123
            host_port      = 123
            protocol       = "UDP"
          }
          security_context {
            privileged  = true
            run_as_user = 0
          }
        }
        host_network = true
      }

    }
  }
}
