variable "vpc_cidr" {
  type        = string
  default     = ""
  description = "The IPv4 CIDR block for the VPC"
}

variable "name" {
  type        = string
  default     = "sample"
  description = "Name to be used on all the resources as identifier"
}

variable "enable_nat_gateway" {
  type        = bool
  default     = false
  description = "Should be true if you want to provision NAT Gateways for each of your private networks"
}

variable "single_nat_gateway" {
  type        = bool
  default     = false
  description = "Should be true if you want to provision a single shared NAT Gateway across all of your private networks"
}

variable "vpc_flow_log_iam_role_use_name_prefix" {
  type        = bool
  default     = false
  description = "Determines whether the IAM role name (`vpc_flow_log_iam_role_name_name`) is used as a prefix"
}

variable "enable_flow_log" {
  type        = bool
  default     = false
  description = "Whether or not to enable VPC Flow Logs"
}

variable "create_flow_log_cloudwatch_log_group" {
  type        = bool
  default     = false
  description = "Whether to create CloudWatch log group for VPC Flow Logs"
}

variable "create_flow_log_cloudwatch_iam_role" {
  type        = bool
  default     = true
  description = "Whether to create IAM role for VPC Flow Logs"
}

variable "flow_log_max_aggregation_interval" {
  type        = number
  default     = 60
  description = "The maximum interval of time during which a flow of packets is captured and aggregated into a flow log record. Valid Values: `60` seconds or `600` seconds"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "A map of tags to add to all resources"
}
