packer {
  required_plugins {
    amazon = {
      version = ">= 1.0.0"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

variable "aws_region" {
  type    = string
  default = "us-east-2"
}

source "amazon-ebs" "amazon_linux" {
  ami_name      = "packer-sample-app-{{timestamp}}"
  instance_type = "t3.micro"
  region        = var.aws_region
  
  source_ami_filter {
    filters = {
      # Utilisation d'un wildcard '*' pour trouver l'image AL2023 la plus récente
      name                = "al2023-ami-2023*-x86_64" 
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    owners      = ["amazon"]
    most_recent = true
  }
  ssh_username = "ec2-user"
}

build {
  sources = ["source.amazon-ebs.amazon_linux"]

  provisioner "file" {
    sources     = ["app.js", "app.config.js"]
    destination = "/tmp/"
  }

  provisioner "shell" {
    inline = [
      "sudo dnf update -y",
      "sudo dnf install -y nodejs",
      "sudo useradd app-user",
      "sudo mkdir -p /home/app-user",
      "sudo mv /tmp/app.js /tmp/app.config.js /home/app-user/",
      "sudo chown -R app-user:app-user /home/app-user",
      "sudo npm install pm2@latest -g",
      
      # Cette commande génère ET exécute la configuration systemd de PM2
      "sudo env PATH=$PATH:/usr/bin pm2 startup systemd -u app-user --hp /home/app-user",
      
      # On s'assure que le service est bien activé (le nom peut varier sur AL2023)
      "sudo systemctl enable pm2-app-user || sudo systemctl enable pm2-app-user.service"
    ]
  }
}
