variable "domain_name" {
  type        = string
  default     = ""
  description = "Hosted Zone Domain name"
}

variable "records" {
  type        = any
  default     = {}
  description = "List of Route53 records"
}

variable "tags" {
  type        = any
  default     = {}
  description = "List of resource tags"
}