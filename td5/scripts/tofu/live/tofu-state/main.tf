provider "aws" {
  region = "us-east-2"
}

module "state" {
  
  source = "github.com/william-zee/devops_base//td5/scripts/tofu/modules/state-bucket"

  
  
  name   = "william-zee-lab5-state-2025"
}
