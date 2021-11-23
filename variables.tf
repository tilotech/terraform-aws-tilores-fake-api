variable "region" {
  type        = string
  description = "The AWS region in which to deploy the API"
}

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

locals {
  prefix = format("%s-tilores", var.resource_prefix)
}
