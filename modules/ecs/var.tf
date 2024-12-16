variable "cluster_name" {
  type        = string
  description = "ECS Cluster name"
}

variable "fargate_capacity_providers" {
  type        = any
  default     = {}
  description = "Map of Fargate capacity provider definitions to use for the cluster"
}

variable "service_name" {
  type        = string
  description = "ECS Service name"
}

variable "service_cpu" {
  type        = number
  description = "ECS Service CPU"
}

variable "service_memory" {
  type        = number
  description = "ECS Service Memory"
}

variable "container_name" {
  type        = string
  description = "ECS Container name"
}

variable "container_cpu" {
  type        = number
  description = "ECS Container CPU"
}

variable "container_memory" {
  type        = number
  description = "ECS Container Memory"
}

variable "container_image_url" {
  type        = string
  description = "ECS Container image URL"
}

variable "container_port" {
  type        = number
  description = "ECS Container port"
}

variable "alb_target_group_arn" {
  type        = string
  description = "ALB target group ARN"
}

variable "subnet_ids" {
  type        = list(string)
  description = "List of subnet IDs"
}

variable "security_group_rules" {
  type        = any
  description = "ECS service security group rules"
}

variable "tags" {
  type        = any
  default     = {}
  description = "List of resource tags"
}
