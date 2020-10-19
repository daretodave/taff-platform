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
  service-name = "${var.service-app-name-prefix}-${var.service-app-name}"
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
  buildpacks = var.service-web-build-packs
  source = {
    path = var.service-web-build-source
  }
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
