
resource "aws_route53_record" "website-a-record" {
    zone_id = var.hosted_zone_id
    name = var.domain_name
    type = "A"
    alias {
        name = aws_cloudfront_distribution.website-cloudfront-distribution.domain_name
        zone_id = aws_cloudfront_distribution.website-cloudfront-distribution.hosted_zone_id
        evaluate_target_health = false
    }
}

resource "aws_route53_record" "website-aaaa-record" {
    zone_id = var.hosted_zone_id
    name = var.domain_name
    type = "AAAA"
    alias {
        name = aws_cloudfront_distribution.website-cloudfront-distribution.domain_name
        zone_id = aws_cloudfront_distribution.website-cloudfront-distribution.hosted_zone_id
        evaluate_target_health = false
    }
}
