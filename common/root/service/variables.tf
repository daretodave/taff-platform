variable "targets" {
  type = list(object({
    service-app-region: string,
    service-app-name: string,
    service-app-name-suffix: string,
    service-app-name-prefix: string,
    service-team-name: string,
    service-web-build-packs: string,
    service-web-build-source: string,
    service-web-formation: object({
      size = string
      quantity = number
    }),
  }))
}

