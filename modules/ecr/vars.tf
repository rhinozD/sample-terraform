variable "ecr_policy" {
  type        = any
  default     = {}
  description = "ECR repository policy"
}

variable "ecr_repo_name" {
  type        = string
  default     = ""
  description = "ECR repository name"
}

variable "repo_policy_enable" {
  type        = bool
  default     = false
  description = "Whether or not enable ECR repository policy"
}

variable "repo_lifecycle_enable" {
  type        = bool
  default     = false
  description = "Whether or not enable ECR repository lifecycle policy"
}

variable "retention_image_number" {
  type        = string
  default     = "7"
  description = "ECR repository lifecycle retention"
}

variable "scan_on_push" {
  type        = bool
  default     = false
  description = "Whether or not enable scan on push image"
}

variable "tags" {
  type        = any
  default     = {}
  description = "resource tags"
}
