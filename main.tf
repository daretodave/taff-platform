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

variable "example_app_name" {
  default = "taff-platform-example-app"
}


resource "heroku_app" "this" {
  name = var.example_app_name
  region = "us"
}

resource "heroku_build" "this" {
  app = heroku_app.this.name
  buildpacks = ["https://github.com/mars/create-react-app-buildpack"]

  source = {
    # This app uses a community buildpack, set it in `buildpacks` above.
    url     = "https://github.com/mars/cra-example-app/archive/v2.1.1.tar.gz"
    version = "v2.1.1"
  }
}

resource "heroku_formation" "this" {
  app        = heroku_app.this.name
  type       = "web"
  quantity   = 1
  size       = "Standard-1x"
  depends_on = [heroku_build.this]
}

output "web_url" {
  value = "https://${heroku_app.this.name}.herokuapp.com"
}
