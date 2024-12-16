variable "name" {
  type        = string
  default     = ""
  description = "The name of the LB"
}

variable "vpc_id" {
  type        = string
  default     = ""
  description = "Identifier of the VPC where the security group will be created"
}

variable "enable_deletion_protection" {
  type        = bool
  default     = false
  description = "If `true`, deletion of the load balancer will be disabled via the AWS API"
}

variable "access_logs" {
  type        = map(any)
  default     = {}
  description = "Map containing access logging configuration for load balancer"
}

variable "security_group_ingress_rules" {
  type        = map(any)
  default     = {}
  description = "Security group ingress rules to add to the security group created"
}

variable "security_group_egress_rules" {
  type        = map(any)
  default     = {}
  description = "Security group egress rules to add to the security group created"
}

variable "subnets" {
  type        = list(string)
  default     = [""]
  description = "A list of subnet IDs to attach to the LB"
}

variable "listeners" {
  type        = any
  default     = {}
  description = "Map of listener configurations to create"
}

variable "target_groups" {
  type        = any
  default     = {}
  description = "Map of target group configurations to create"
}

variable "tags" {
  type        = any
  default     = {}
  description = "A map of tags to add to all resources"
}
