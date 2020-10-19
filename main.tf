terraform {
  backend "remote" {
    organization = "taff"
    workspaces {
      name = "ci-develop"
    }
  }
}

module "runtime" {
  source = "./runtime"

  service-team-name = "taff"

}