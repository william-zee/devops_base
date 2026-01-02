output "all_public_ips" {
  description = "Les adresses IP de tous les serveurs"
  # Le [*] veut dire : "donne moi les IP de TOUTES les instances du count"
  value       = aws_instance.sample_app[*].public_ip
}
