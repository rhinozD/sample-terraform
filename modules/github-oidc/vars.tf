variable "repositories" {
  type        = list(string)
  default     = [""]
  description = "List of Github repositories"
}

variable "policy_arns" {
  type        = list(string)
  default     = [""]
  description = "List of IAM policies to attach to Github OIDC role"
}

variable "role_name" {
  type        = string
  default     = ""
  description = "Github OIDC role name"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "A map of tags"
}