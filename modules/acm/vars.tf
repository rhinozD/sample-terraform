variable "domain_name" {
  type        = string
  default     = ""
  description = "A domain name for which the certificate should be issued"
}

variable "zone_id" {
  type        = string
  default     = ""
  description = "The ID of the hosted zone to contain this record. Required when validating via Route53"
}

variable "subject_alternative_names" {
  type        = list(string)
  default     = [""]
  description = "A list of domains that should be SANs in the issued certificate"
}

variable "tags" {
  type        = any
  default     = {}
  description = "A mapping of tags to assign to the resource"
}

