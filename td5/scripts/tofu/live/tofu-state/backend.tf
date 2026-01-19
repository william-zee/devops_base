terraform {
  backend "s3" {
    bucket         = "william-zee-lab5-state-2025"
    key            = "td5/scripts/tofu/live/tofu-state/terraform.tfstate"
    region         = "us-east-2"
    encrypt        = true
    dynamodb_table = "william-zee-lab5-state-2025"
  }
}
