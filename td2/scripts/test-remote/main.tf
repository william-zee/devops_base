module "app_from_github" {
  source         = "github.com/william-zee/opentofu-modules.git//"
  ami_id         = "ami-0f5e0b87de531c40d"
  instance_count = 1
}

output "url" {
  value = "http://${module.app_from_github.all_public_ips[0]}:8080"
}
