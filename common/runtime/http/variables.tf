variable "default-environment-name" {
  type = string

  default = "develop"
}

variable "app-compute-profile" {
  type = string

  default = "Standard-1x"
}

variable "app-compute-hosts" {
  type = number

  default = 1
}

variable "default-service-web-build-packs" {
  type = list(string)
  description = "The build packs to use."

  default = [
    "https://github.com/heroku/heroku-buildpack-nodejs.git"
  ]
}

variable "src" {
  type = any
  description = "The build info."

  default = "service"
}

variable "default-service-team-name" {
  type = string
  description = "The team to deploy services under."

  default = "taff"
}


variable "default-service-app-region" {
  type = string
  description = "The service deployed region."

  default = "us"
}


variable "default-service-name-prefix" {
  type = string
  default = "taff-service"
}


variable "base" {
  default = {
    name: "edge",
    size: 2,
    host: "Standard-1x",
    pipe: {
      ENV: "develop"
    },
    region: "us"
  }
  type         = any
  description = "The service env base"
}


variable "target" {
  default = [{
      name: "edge",
      size: 2,
      host: "Standard-1x",
      pipe: {
        ENV: "develop"
      },
      region: "us"
    }]
  type         = any
  description = "The service env/target"
}

