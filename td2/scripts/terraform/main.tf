terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-2"
}

# 1. Création du groupe de sécurité (Pare-feu)
resource "aws_security_group" "sample_app_sg" {
  name        = "sample-app-terraform-sg"
  description = "Allow HTTP and SSH"

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# 2. Lancement de l'instance basée sur TON image Packer
resource "aws_instance" "sample_app" {
  ami           = var.ami_id # <-- TON ID AMI CRÉÉ EN SECTION 4
  count         = var.instance_count
  instance_type =var.instance_type
  vpc_security_group_ids = [aws_security_group.sample_app_sg.id]
  user_data = file("${path.module}/user-data.sh")
  tags = {
    Name = "SampleApp-Terraform"
  }
}

# 3. Afficher l'IP de la machine à la fin

