resource "random_id" "runtime_service" {
  byte_length = 4
}

variable "service-name" {
  type = string
  description = "The key to deploy the app under."
  default = ""
}

module "server" {
  source = "../../root/service"

  service-team-name = var.default-service-team-name
  service-app-region = var.default-service-app-region
  service-app-name-prefix = var.default-service-name-prefix
  service-app-name =  var.service-name
  service-web-formation = {
    size = var.default-service-web-formation-size
    quantity = var.default-service-web-formation-quantity
  }
  service-web-build-packs = var.default-service-web-build-packs
  service-web-build-source = var.default-service-web-build-source
}

