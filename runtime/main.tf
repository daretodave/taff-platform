terraform {
  required_providers {
    heroku = {
      source = "heroku/heroku"
      version = "2.6.0"
    }
  }
  backend "remote" {
    organization = "taff"
    workspaces {
      name = "ci-develop"
    }
  }
}

provider "heroku" {
}

resource "heroku_app" "this" {
  name   = "taff-platform-test-app"
  region = "us"
}

resource "heroku_build" "this" {
  app = "${heroku_app.this.name}"
  buildpacks = ["https://github.com/heroku/heroku-buildpack-nodejs.git"]
  source = {
     path = "../test"
  }
}

resource "heroku_formation" "this" {
  app        = "${heroku_app.this.name}"
  type       = "web"
  quantity   = 1
  size       = "Standard-1x"
  depends_on = ["heroku_build.this"]
}

output "web_url" {
   value = "https://${heroku_app.this.name}.herokuapp.com"
}
