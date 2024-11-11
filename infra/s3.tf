
resource "aws_s3_bucket" "website-s3-bucket" {
    bucket = var.domain_name

    tags = {
        Name = var.domain_name
    }
}

resource "aws_s3_bucket_policy" "website-s3-bucket-policy" {
    bucket = aws_s3_bucket.website-s3-bucket.bucket
    policy = data.aws_iam_policy_document.website-s3-cloudfront-policy.json
}

resource "aws_s3_object" "website-s3-data" {
    for_each = fileset("${path.module}/../dist/frontend", "**/*")

    bucket = aws_s3_bucket.website-s3-bucket.bucket
    key = each.value
    source = "${path.module}/../dist/frontend/${each.value}"
    etag = filemd5("${path.module}/../dist/frontend/${each.value}")
}