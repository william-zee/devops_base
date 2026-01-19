provider "aws" {
  region = "us-east-2"
}

# 1. CE BLOC ÉTAIT MANQUANT : Il crée la connexion GitHub <-> AWS
module "oidc_provider" {
  source = "github.com/william-zee/devops_base//td5/scripts/tofu/modules/github-aws-oidc"
}

# 2. CE BLOC CRÉE LES RÔLES : Il utilise l'ID du bloc au-dessus
module "iam_roles" {
  source = "github.com/william-zee/devops_base//td5/scripts/tofu/modules/gh-actions-iam-roles"

  name              = "lambda-sample"
  oidc_provider_arn = module.oidc_provider.oidc_provider_arn # Correction de la référence

  enable_iam_role_for_testing = true
  enable_iam_role_for_plan    = true
  enable_iam_role_for_apply   = true

  github_repo               = "william-zee/devops_base"
  lambda_base_name          = "lambda-sample"
  tofu_state_bucket         = "william-zee-lab5-state-2025"
  tofu_state_dynamodb_table = "william-zee-lab5-state-2025"
}
