module "github_oidc" {
  source = "../../modules/github-oidc"
  repositories = [
    "rhinozD/python-app"
  ]
  policy_arns = [
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPowerUser",
    resource.aws_iam_policy.ecs_deploy_policy.arn
  ]
  role_name = "${local.name_prefix}-github-oidc-provider"
}

resource "aws_iam_policy" "ecs_deploy_policy" {
  name        = "ECSDeployPolicy"
  description = "Policy for GitHub Actions to deploy to ECS"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "ecs:DescribeClusters",
          "ecs:DescribeServices",
          "ecs:DescribeTaskDefinition",
          "ecs:UpdateService",
          "ecs:ListTasks",
          "ecs:DescribeTasks",
          "ecs:RegisterTaskDefinition"
        ],
        Resource = "*"
      },
      {
        "Effect" : "Allow",
        "Action" : "iam:PassRole",
        "Resource" : [
          "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/${local.name}-service-*"
        ],
        "Condition" : {
          "StringEquals" : {
            "iam:PassedToService" : "ecs-tasks.amazonaws.com"
          }
        }
      }
    ]
  })
}