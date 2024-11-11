provider "aws" {
    region = var.region
}

module "template_files" {
  source  = "hashicorp/dir/template"

  base_dir = "${path.module}/../dist/frontend"
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