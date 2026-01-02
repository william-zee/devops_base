output "api_endpoint" {
  description = "L'URL publique de ton application Lambda"
  value       = module.gateway.api_endpoint
}
