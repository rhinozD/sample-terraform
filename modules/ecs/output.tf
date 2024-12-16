output "cluster_id" {
  description = "ECS cluster ID"
  value       = module.ecs.cluster_id
}

output "cluster_arn" {
  description = "ECS cluster ARN"
  value       = module.ecs.cluster_arn
}

output "services" {
  description = "Map of services created and their attributes"
  value       = module.ecs.services
}

output "task_exec_iam_role_arn" {
  description = "Task execution IAM role ARN"
  value       = module.ecs.task_exec_iam_role_arn
}