variable "vpc_id" {
  type        = string
  default     = null
  description = "The ID of the VPC in which the endpoint will be used"
}

variable "create_security_group" {
  type        = bool
  default     = false
  description = "Determines if a security group is created"
}

variable "security_group_name" {
  type        = string
  default     = null
  description = "Name to use on security group created"
}

variable "security_group_description" {
  type        = string
  default     = ""
  description = "The description of the security group"
}

variable "security_group_rules" {
  type        = any
  default     = {}
  description = "Security group rules to add to the security group created"
}

variable "security_group_tags" {
  type        = map(string)
  default     = {}
  description = "A map of additional tags to add to the security group created"
}

variable "endpoint" {
  type        = any
  default     = {}
  description = "A map of interface and/or gateway endpoints containing their properties and configurations"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "A map of tags to use on all resources"
}