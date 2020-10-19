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

  targets = [for stage in var.target: {
    service-team-name =  lookup(var, "default-service-team-name", var.base.size)
    service-app-region = var.default-service-app-region
    service-app-name-prefix = var.default-service-name-prefix
    service-app-name-suffix = stage.name
    service-app-name = var.name
    service-web-formation = {
      size = lookup(stage, "host", var.app-compute-hosts)
      quantity = lookup(stage, "size", var.app-compute-profile)
    }
    service-web-build-packs = var.default-service-web-build-packs
    service-web-build-source = var.src
  }]

  service-team-name = var.default-service-team-name
  service-app-region = var.default-service-app-region
  service-app-name-prefix = var.default-service-name-prefix
  service-app-name = var.name
  service-web-formation = {
    size = var.app-compute-hosts
    quantity = var.app-compute-profile
  }
  service-web-build-packs = var.default-service-web-build-packs
  service-web-build-source = var.src
}

