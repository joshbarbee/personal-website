resource "aws_cloudfront_distribution" "website-cloudfront-distribution" {
    origin {
        domain_name = aws_s3_bucket.website-s3-bucket.bucket_regional_domain_name
        origin_id = aws_s3_bucket.website-s3-bucket.bucket_regional_domain_name
        origin_access_control_id = aws_cloudfront_origin_access_control.website-cloudfront-oac.id
    }

    aliases = [var.domain_name]

    enabled = true
    is_ipv6_enabled = true

    default_cache_behavior {
        allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
        cached_methods   = ["GET", "HEAD"]
        target_origin_id = aws_s3_bucket.website-s3-bucket.bucket_regional_domain_name

        forwarded_values {
            query_string = true

            cookies {
                forward = "none"
            }
        }

        viewer_protocol_policy = "redirect-to-https"
        min_ttl                = 0
        default_ttl            = 3600
        max_ttl                = 86400
    }

    viewer_certificate {
        acm_certificate_arn = aws_acm_certificate.website-cert.arn
        ssl_support_method = "sni-only"
    }

    restrictions {
        geo_restriction {
            restriction_type = "none"
        }
    }

    price_class = "PriceClass_100"

    default_root_object = "index.html"
}

resource "aws_cloudfront_origin_access_control" "website-cloudfront-oac" {
    name = "website-cloudfront-oac"
    description = "Restrict access to the S3 bucket"
    origin_access_control_origin_type = "s3"
    signing_behavior = "always"
    signing_protocol = "sigv4"
}