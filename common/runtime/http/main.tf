resource "random_id" "runtime_service" {
  byte_length = 4
}

variable "name" {
  type = string
  description = "The key to deploy the app under."
  default = ""
}

module "server" {
  source = "../../root/service"
  targets = {
  for stage in var.target:
  stage.name => {
    service-team-name = var.default-service-team-name
    service-app-region = var.default-service-app-region
    service-app-name-prefix = var.default-service-name-prefix
    service-app-name-suffix = stage.name
    service-app-name = var.name
    service-web-formation = {
      host = lookup(stage, "host", var.app-compute-hosts)
      size = lookup(stage, "size", var.app-compute-profile)
    }
    service-web-build-packs = var.default-service-web-build-packs
    service-web-build-source = var.src
  }
  }

  service-team-name = var.default-service-team-name
  service-app-name-prefix = var.default-service-name-prefix
  service-app-name = var.name
  service-web-build-packs = var.default-service-web-build-packs
  service-web-build-source = var.src
}

