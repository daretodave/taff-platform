resource "random_id" "runtime_service" {
  byte_length = 4
}

variable "service-name" {
  type = string
  description = "The key to deploy the app under."
  default = ""
}

variable "service-prefix" {
  type = string
  description = "The key to deploy the app under."
  default = var.default-service-team-name
}

locals {
  service-name-suffix = lower("%{ if var.service-name == "" }service-${random_id.runtime_service.hex}%{ else }${var.service-name}%{ endif }")
}

module "server" {
  source = "../../root/service"

  service-team-name = var.default-service-team-name
  service-app-region = var.default-service-app-region
  service-app-label-prefix = lower("%{ if var.service-prefix != "" }${var.service-prefix}-${local.service-name-suffix}%{ else }${var.service-prefix}%{ endif }")
  service-app-label =  local.service-name-suffix
  service-web-formation = {
    size = var.default-service-web-formation-size
    quantity = var.default-service-web-formation-quantity
  }
  service-web-build-packs = var.default-service-web-build-packs
  service-web-build-source = var.default-service-web-build-source
}

