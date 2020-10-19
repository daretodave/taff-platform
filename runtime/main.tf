terraform {
  required_providers {
    heroku = {
      source = "heroku/heroku"
      version = "2.6.1"
    }
  }
}

provider "heroku" {
  version = "~> 2.0"
}

variable "example_app_name" {
  default = "taff-platform-example-app"
}


resource "heroku_app" "this" {
 name = var.example_app_name
  region = "us"
}

resource "heroku_build" "this" {
  app = heroku_app.this.name
  buildpacks = ["https://github.com/heroku/heroku-buildpack-nodejs.git"]
  source = {
     path = "../test"
  }
}

resource "heroku_formation" "this" {
  app        = heroku_app.this.name
  type       = "web"
  quantity   = 1
  size       = "Standard-1x"
  depends_on = ["heroku_build.this"]
}

output "web_url" {
   value = "https://${heroku_app.this.name}.herokuapp.com"
}
