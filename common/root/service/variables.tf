
variable "service-web-build-source" {
  type        = string
  description = "The build info."
  default = "service"
}

variable "service-web-build-packs" {
  type        = list(string)
  description = "The build info."
  default = []
}

variable "service-team-name" {
  type        = string
  description = "The team to deploy services under."
}

variable "service-app-name-prefix" {
  type        = string
  description = "The name prefix."
}

variable "service-app-name" {
  type        = string
  description = "The suffix when building the build and app names."
}


variable "targets" {
  type = map(any)
  default = {
      edge = {
        service-app-name-suffix = "edge",
        service-app-region = "us",
        service-web-formation = {
          host = 2,
          size = "Standard-1x",
        }
      }
    }

}

