module "ecr" {
  source                = "../../modules/ecr"
  ecr_repo_name         = "${local.name_prefix}-ecr-repo"
  scan_on_push          = false
  repo_lifecycle_enable = false
  repo_policy_enable    = false
  tags = merge(
    local.tags,
    {
      Name = "${local.name_prefix}-ecr-repo"
    }
  )
}