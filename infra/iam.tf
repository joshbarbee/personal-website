
data "aws_iam_policy_document" "website-s3-cloudfront-policy" {
    statement {
        principals {
            type = "service"
            identifiers = [
                "cloudfront.amazonaws.com",
            ]
        }

        condition {
            test = "StringEquals"
            values = [
                aws_cloudfront_distribution.website-cloudfront-distribution.arn,
            ]
            variable = "aws:SourceArn"
        }

        actions = [
            "s3:GetObject",
        ]

        resources = [
            aws_s3_bucket.website-s3-bucket.arn,
            "${aws_s3_bucket.website-s3-bucket.arn}/*",
        ]
    }
}

