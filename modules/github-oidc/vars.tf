variable "repositories" {
  type        = list(string)
  description = "List of Github repositories"
}

variable "policy_arns" {
  type        = list(string)
  description = "List of IAM policies to attach to Github OIDC role"
}

variable "role_name" {
  type        = string
  description = "Github OIDC role name"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "A map of tags"
}