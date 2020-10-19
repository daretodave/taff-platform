terraform {
  required_providers {
    heroku = {
      source = "heroku/heroku"
      version = "2.6.0"
    }
  }
}

provider "heroku" {}


locals {
  service-name = "${var.service-team-name}-${var.service-app-label}"
}

variable "service-web-formation" {
  type        = object({
    size = string
    quantity = number
  })
  default = {
    size = "Standard-1x"
    quantity = 1
  }
  description = "The formation used for services in runtime."
}

variable "service-web-build" {
  type        = any
  description = "The build info."
}

variable "service-team-name" {
  type        = string
  description = "The team to deploy services under."
}

variable "service-app-label" {
  type        = string
  description = "The suffix when building the build and app names."
}

variable "service-app-region" {
  type        = string
  description = "The service deployed region."
}


resource "heroku_app" "this" {
  name = local.service-name
  region = var.service-app-region

  organization {
    name =  var.service-team-name
  }
}

resource "heroku_build" "this" {
  app = heroku_app.this.name
  buildpacks = var.service-web-build.build-packs
  source = var.service-web-build.source
}

resource "heroku_formation" "this" {
  app        = heroku_app.this.name
  type       = "web"
  quantity   = var.service-web-formation.quantity
  size       = var.service-web-formation.size
  depends_on = [heroku_build.this]
}

output "web_url" {
  value = "https://${heroku_app.this.name}.herokuapp.com"
}
