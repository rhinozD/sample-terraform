module "github_oidc" {
  source  = "terraform-module/github-oidc-provider/aws"
  version = "2.2.1"

  create_oidc_provider = true
  create_oidc_role     = true

  repositories              = var.repositories
  oidc_role_attach_policies = var.policy_arns
  role_name                 = var.role_name

  tags = var.tags
}
