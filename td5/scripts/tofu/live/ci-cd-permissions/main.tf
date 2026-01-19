module "iam_roles" {
  source = "github.com/william-zee/devops_base//td5/scripts/tofu/modules/gh-actions-iam-roles"

  name              = "lambda-sample"
  oidc_provider_arn = module.oidc_provider.oidc_provider_arn

  enable_iam_role_for_testing = true
  enable_iam_role_for_plan    = true  # On active ça (Partie 2)
  enable_iam_role_for_apply   = true  # On active ça (Partie 2)

  # TON REPO GITHUB (Attention à ne pas mettre d'espace)
  github_repo = "william-zee/devops_base"

  lambda_base_name          = "lambda-sample"
  
  # TES INFOS DE BUCKET (Créées juste avant)
  tofu_state_bucket         = "william-zee-lab5-state-2025"
  tofu_state_dynamodb_table = "william-zee-lab5-state-2025"
}
