variable "name" {
  type        = string
  default     = ""
  description = "Security group name"
}

variable "vpc_id" {
  type        = string
  default     = ""
  description = "VPC ID"
}

variable "ingress_with_cidr_blocks" {
  type        = list(map(string))
  default     = []
  description = "Security group ingress with CIDR blocks"
}

variable "ingress_with_source_security_group_id" {
  type        = list(map(string))
  default     = []
  description = "Security group ingress with source security group ID"
}

variable "egress_with_cidr_blocks" {
  type        = list(map(string))
  default     = []
  description = "Security group egress with CIDR blocks"
}

variable "egress_with_source_security_group_id" {
  type        = list(map(string))
  default     = []
  description = "Security group egress with source security group ID"
}

variable "ingress_with_self" {
  type        = list(map(string))
  default     = []
  description = "Security group ingress with self"
}

variable "egress_with_self" {
  type        = list(map(string))
  default     = []
  description = "Security group egress with self"
}

variable "tags" {
  type        = any
  default     = {}
  description = "List of resource tags"
}
