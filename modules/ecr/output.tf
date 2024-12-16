output "ecr_repo_arn" {
  description = "ECR repository ARN"
  value       = aws_ecr_repository.ecr.arn
}

output "ecr_repo_url" {
  description = "ECR repository URL"
  value       = aws_ecr_repository.ecr.repository_url
}