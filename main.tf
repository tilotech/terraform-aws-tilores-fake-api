module "lambda_api" {
  source = "terraform-aws-modules/lambda/aws"

  function_name = format("%s-api", local.prefix)
  description   = "TiloRes Fake API"
  handler       = "api"
  runtime       = "go1.x"

  create_package         = false
  local_existing_package = var.api_file

  layers = [
    module.lambda_layer_dispatcher_plugin.lambda_layer_arn,
  ]

  allowed_triggers = {
    APIGateway = {
      service    = "apigateway"
      source_arn = format("%s/*/*/*", module.api_gateway.apigatewayv2_api_execution_arn)
    }
  }
  create_current_version_allowed_triggers = false
}

module "lambda_layer_dispatcher_plugin" {
  source = "terraform-aws-modules/lambda/aws"

  create_layer = true

  layer_name          = format("%s-dispatcher-plugin", local.prefix)
  description         = "TiloRes Fake API Dispatcher Plugin"
  compatible_runtimes = ["go1.x"]

  create_package         = false
  local_existing_package = var.dispatcher_file
}

module "api_gateway" {
  source = "terraform-aws-modules/apigateway-v2/aws"

  name          = format("%s-api", local.prefix)
  description   = "TiloRes Fake API Gateway"
  protocol_type = "HTTP"

  create_api_domain_name = false

  integrations = {
    "POST /" = {
      lambda_arn             = module.lambda_api.lambda_function_arn
      payload_format_version = "1.0"
      authorization_type     = "JWT"
      authorizer_id          = aws_apigatewayv2_authorizer.api_authorizer.id
    }
  }
}

resource "aws_apigatewayv2_authorizer" "api_authorizer" {
  api_id           = module.api_gateway.apigatewayv2_api_id
  authorizer_type  = "JWT"
  identity_sources = ["$request.header.Authorization"]
  name             = format("%s-authorizer", local.prefix)

  jwt_configuration {
    audience = var.authorizer_audience
    issuer   = var.authorizer_issuer_url
  }
}