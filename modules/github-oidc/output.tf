output "oidc_provider_arn" {
  description = "The ARN of the OIDC Provider"
  value       = module.github_oidc.oidc_provider_arn
}

output "oidc_role" {
  description = "The OIDC Role"
  value       = module.github_oidc.oidc_role
}