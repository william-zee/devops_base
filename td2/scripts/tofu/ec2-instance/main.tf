provider "aws" {
  region = "us-east-2"
}

# Bloc pour le Load Balancer (ALB)
module "alb" {
  source = "../../modules/alb"
  name                  = "sample-app-alb"
  alb_http_port         = 80
  app_http_port         = 8080
  app_health_check_path = "/"
}

# Bloc pour les Serveurs (ASG)
module "asg" {
  source = "../../modules/asg"
  name             = "sample-app-asg"
  ami_id           = "ami-0905ad54b5deb4643" # Ton AMI
  user_data        = filebase64("${path.module}/user-data.sh")
  instance_type    = "t3.micro"
  app_http_port    = 8080
  min_size         = 1
  max_size         = 10
  desired_capacity = 3
  

# 1. On lie les serveurs au Load Balancer (À l'extérieur du refresh)
  target_group_arns = [module.alb.target_group_arn]

  # 2. Le bloc pour la mise à jour automatique
  instance_refresh = {
    strategy               = "Rolling"
    min_healthy_percentage = 100
  }
}
