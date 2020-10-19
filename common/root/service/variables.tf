variable "service-web-formation" {
  type        = object({
    size = string
    quantity = number
  })
  default = {
    size = "Standard-1x"
    quantity = 1
  }
  description = "The formation used for services in runtime."
}

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

variable "service-app-region" {
  type        = string
  description = "The service deployed region."
}
