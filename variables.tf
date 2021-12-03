variable "resource_prefix" {
  type        = string
  description = "The text every created resource will be prefixed with."
}

variable "api_file" {
  type        = string
  description = "The path to the built and zipped API artifact."
}

variable "dispatcher_file" {
  type        = string
  description = "The path to the built and zipped Fake Dispatcher plugin."
}

variable "authorizer_issuer_url" {
  type = string
  description = "The issuer URL to be used by the authorizer (for cognito it is the user pool endpoint)"
}

variable "authorizer_audience" {
  type = list(string)
  description = "A list of allowed token recipient identifiers  (for cognito it is the client ID)"
}

locals {
  prefix = format("%s-tilores", var.resource_prefix)
}
