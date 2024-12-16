output "security_group_arn" {
  description = "The ARN of the security group"
  value       = module.security_group.security_group_arn
}

output "security_group_id" {
  description = "The ID of the security group"
  value       = module.security_group.security_group_id
}