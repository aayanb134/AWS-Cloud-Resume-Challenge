variable "certificate_arn" {
  description = "certificate arn"
  type        = string
  default     = "arn:aws:acm:us-east-1:257747315190:certificate/57bc7164-f426-4cc8-82f7-c0f4b6c1608f"
}

variable "aws_region" {
  description = "region where resources will be created"
  type        = string
  default     = "eu-west-2"
}

variable "route53_zone" {
  description = "name of route53 zone"
  type        = string
  default     = "aayan-resume.com"
}
