provider "aws" {
  region = "us-east-2"
}

module "function" {
  # On pointe vers TON dépôt
  source = "github.com/william-zee/devops_base//td5/scripts/tofu/modules/lambda"

  name = "lambda-sample"
  src  = "${path.module}/src"
}

module "gateway" {
  # On pointe vers TON dépôt
  source = "github.com/william-zee/devops_base//td5/scripts/tofu/modules/api-gateway"

  name                = "lambda-sample"
  function_arn        = module.function.function_arn
  function_name       = module.function.function_name
  api_gateway_route_key = "GET /"
}

# Ce module sert pour les tests automatisés du pipeline
module "test" {
  source = "github.com/william-zee/devops_base//td5/scripts/tofu/modules/test-endpoint"

  endpoint = module.gateway.api_endpoint
}

output "api_endpoint" {
  value = module.gateway.api_endpoint
}
