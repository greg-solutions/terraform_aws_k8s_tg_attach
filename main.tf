resource "kubernetes_namespace" "namespace" {
  count = var.create_namespace ? 1 : 0
  metadata {
    annotations = {
      name = var.namespace
    }
    name = var.namespace
  }
}
resource "kubernetes_config_map" "script" {
  metadata {
    name = var.name
    namespace = var.create_namespace ? kubernetes_namespace.namespace.0.id : var.namespace
    labels = {
      app = var.name
    }
  }
  data = {
    "attach-to-tg"  = data.template_file.script.rendered
  }
}
resource "kubernetes_daemonset" "attach_job" {
  metadata {
    name = var.name
    namespace = var.create_namespace ? kubernetes_namespace.namespace.0.id : var.namespace
    labels = {
      app = var.name
    }
  }
  spec {
    selector {
      match_labels = {
        "app" = var.name
      }
    }
    template {
      metadata {
        labels = {
          app = var.name
        }
      }
      spec {
        init_container {
          name = var.name
          image = "amazon/aws-cli:2.0.15"
          command = ["/bin/bash", "/attach-to-tg.sh"]
          volume_mount {
            mount_path = "/attach-to-tg.sh"
            name = "script"
            sub_path = "attach-to-tg"
          }
        }
        container {
          name = "pause"
          image = "gcr.io/google_containers/pause"
        }
        volume {
          config_map {
            default_mode = "0777"
            name = kubernetes_config_map.script.metadata[0].name
          }
          name = "script"
        }
      }
    }
  }
}
