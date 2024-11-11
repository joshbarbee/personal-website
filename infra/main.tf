provider "aws" {
    region = var.region
}

resource "aws_acm_certificate" "website-cert" {
    domain_name = var.domain_name
    validation_method = "DNS"

    tags = {
        Name = var.domain_name
    }

    lifecycle {
        create_before_destroy = true
    }
}