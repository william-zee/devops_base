provider "aws" {
  region = "us-east-2"
}

module "function" {
  source = "../../modules/lambda-sample"

  
  name   = var.name
}
