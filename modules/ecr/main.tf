resource "aws_ecr_repository" "ecr" {
  name = var.ecr_repo_name
  image_scanning_configuration {
    scan_on_push = var.scan_on_push
  }
  tags = merge(
    var.tags,
    {
      Name = var.ecr_repo_name
    }
  )
}

resource "aws_ecr_repository_policy" "ecr" {
  count      = var.repo_policy_enable ? 1 : 0
  repository = aws_ecr_repository.ecr.name
  policy     = var.ecr_policy
}

resource "aws_ecr_lifecycle_policy" "ecr" {
  count      = var.repo_lifecycle_enable ? 1 : 0
  repository = aws_ecr_repository.ecr.name
  policy = templatefile("${path.module}/lifecycle_policy.json",
    {
      number = var.retention_image_number
    }
  )
}