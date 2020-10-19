
variable "service-team-name" {}

module "service" {
  source = "./service"

  service-team-name = var.service-team-name
  service-app-region = "us"
  service-app-label = "test-sample"
  service-web-formation = {
    size = "Standard-1x"
    quantity = 1
  }
  service-web-build = {
    build-packs = []
    source = {
      path = "test/service"
    }
  }
}