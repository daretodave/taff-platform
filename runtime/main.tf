terraform {
  required_providers {
    heroku = {
      source = "heroku/heroku"
      version = "2.6.1"
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
  version = "~> 2.0"
}

resource "heroku_app" "this" {
  name   = "taff-platform-test-app"
  region = "us"
}

resource "heroku_build" "this" {
  depends_on = []
  app = heroku_app.this.id
  source = {
    path = "../test"
  }
  provisioner "local-exec" {
    command = "bash ../scripts/health-check ${heroku_app.this.web_url}"
  }
}

output "web_url" {
  value = heroku_app.this.web_url 
}
