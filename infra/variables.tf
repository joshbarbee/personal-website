
variable "hosted_zone_id" {
    description = "The Route 53 hosted zone ID"
    type        = string
    default  = "Z0260833NB8DZ80E7EL9"
}

variable "domain_name" {
    description = "The domain name for the website"
    type        = string
    default     = "joshbarbee.com"
}

variable "region" {
    description = "The AWS region to deploy the infrastructure"
    type        = string
    default     = "us-east-1"
}

variable "email" {
    description = "The email address to send notifications to"
    type        = string
    default     = "joshbarbee1@gmail.com"
}
