resource "aws_s3_bucket" "website-s3-bucket" {
    bucket = var.domain_name

    tags = {
        Name = var.domain_name
    }
}

resource "aws_s3_bucket_public_access_block" "website-s3-bucket-public-access-block" {
    bucket = aws_s3_bucket.website-s3-bucket.bucket

    block_public_acls = true
    block_public_policy = false
    ignore_public_acls = true
    restrict_public_buckets = true
}

resource "aws_s3_bucket_policy" "website-s3-bucket-policy" {
    bucket = aws_s3_bucket.website-s3-bucket.bucket

    policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
            {
                Effect = "Allow"
                Principal = aws_cloudfront_distribution.website-cloudfront-distribution.arn
                Action = "s3:GetObject"
                Resource = "${aws_s3_bucket.website-s3-bucket.arn}/*"
            }
        ]
    })

    depends_on = [
        aws_s3_bucket.website-s3-bucket
    ]
}

resource "aws_s3_object" "website-s3-data" {
    for_each = module.template_files.files

    bucket = aws_s3_bucket.website-s3-bucket.bucket
    key          = each.key
    content_type = each.value.content_type
    source  = each.value.source_path
    content = each.value.content
    etag = each.value.digests.md5
}

resource "aws_s3_bucket" "website-s3-logs-bucket" {
    bucket = "${var.domain_name}-logs"

    tags = {
        Name = "${var.domain_name}-logs"
    }
}

resource "aws_s3_bucket_ownership_controls" "website-s3-logs-bucket-ownership-controls" {
    bucket = aws_s3_bucket.website-s3-logs-bucket.bucket

    rule {
        object_ownership = "ObjectWriter"
    }
}