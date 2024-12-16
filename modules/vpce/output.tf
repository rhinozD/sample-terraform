output "endpoints" {
  description = "Array containing the full resource object and attributes for all endpoints created"
  value       = module.vpc_endpoint.endpoints
}

output "security_group_arn" {
  description = "Amazon Resource Name (ARN) of the security group"
  value       = module.vpc_endpoint.security_group_arn
}

output "security_group_id" {
  description = "ID of the security group"
  value       = module.vpc_endpoint.security_group_id
}