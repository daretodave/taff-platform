variable "default-environment-name" {
  type = string

  default = "develop"
}

variable "default-service-web-formation-size" {
  type = string

  default = "Standard-1x"
}

variable "default-service-web-formation-quantity" {
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

variable "default-service-web-build-source" {
  type = any
  description = "The build info."

  default = {}
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



