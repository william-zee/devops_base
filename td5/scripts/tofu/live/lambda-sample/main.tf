provider "aws" {
  region = "us-east-2"
}

module "function" {
  source      = "../../modules/lambda"
  name        = "lambda-sample"
  src_dir     = "${path.module}/src"
  runtime     = "nodejs20.x"
  handler     = "index.handler"
  memory_size = 128
  timeout     = 5
}
module "gateway" {
  source = "../../modules/api-gateway"
  name                = "lambda-sample"
  function_arn        = module.function.function_arn
  function_name       = module.function.function_name
  api_gateway_route_key = "GET /"
}
module "test" {
  source = "../../modules/test-endpoint"
  endpoint = module.gateway.api_endpoint
}

output "api_endpoint" {
  value = module.gateway.api_endpoint
}
