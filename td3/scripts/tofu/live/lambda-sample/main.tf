provider "aws" {
  region = "us-east-2"
}

module "function" {
  # Utilisation du dépôt GitHub de ton cours
  source = "github.com/BTajini/devops-base//td3/tofu/modules/lambda"

  name      = "lambda-sample" 
  src_dir   = "${path.module}/src" 
  runtime   = "nodejs20.x" 
  handler   = "index.handler" 
  memory_size = 128 
  timeout     = 5 
  environment_variables = { 
    NODE_ENV = "production"
  }
}

module "gateway" {
  # Utilise toujours le dépôt de ton professeur
  source = "github.com/BTajini/devops-base//td3/tofu/modules/api-gateway"

  name         = "lambda-sample" # Nom de l'API
  function_arn = module.function.function_arn # On lie l'API à ta fonction Lambda
  api_gateway_routes = ["GET /"] # On autorise les requêtes HTTP GET sur la racine
}
