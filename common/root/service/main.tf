terraform {
  required_providers {
    heroku = {
      source = "heroku/heroku"
      version = "2.6.0"
    }
  }
}

provider "heroku" {}

resource "heroku_app" "this" {
  for_each = var.targets

  name = "${var.service-app-name-prefix}-${var.service-app-name}-${each.value.service-app-name-suffix}"
  region = each.value.service-app-region

  organization {
    name =  var.service-team-name
  }
}

resource "heroku_build" "this" {
  for_each = var.targets

  app = heroku_app.this[each.key].name
  buildpacks = var.service-web-build-packs
  source = {
    path = var.service-web-build-source
  }
}

resource "heroku_formation" "this" {
  for_each = var.targets

  app = heroku_app.this[each.key].name
  type       = "web"
  quantity   =  each.value.service-web-formation.size
  size       = each.value.service-web-formation.host
  depends_on = [heroku_build.this]
}

output "web_url" {
  value = "https://${heroku_app.this.name}.herokuapp.com"
}
