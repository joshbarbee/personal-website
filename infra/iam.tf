
resource "aws_iam_role" "website-lambda-role-put" {
    name = "website-lambda-role-put"
    assume_role_policy = jsonencode({
        Version = "2012-10-17",
        Statement = [
            {
                Effect = "Allow",
                Principal = {
                    Service = [
                        "lambda.amazonaws.com",
                    ]
                },
                Action = "sts:AssumeRole"
            }
        ]
    })
}

resource "aws_iam_role" "website-lambda-role-get" {
    name = "website-lambda-role-get"
    assume_role_policy = jsonencode({
        Version = "2012-10-17",
        Statement = [
            {
                Effect = "Allow",
                Principal = {
                    Service = [
                        "lambda.amazonaws.com",
                    ]
                },
                Action = "sts:AssumeRole"
            }
        ]
    })
}

resource "aws_iam_policy" "website-lambda-policy-cloudwatch" {
    name = "website-lambda-policy-cloudwatch"
    policy = jsonencode({
        Version = "2012-10-17",
        Statement = [
            {
                Effect = "Allow",
                Action = [
                    "logs:CreateLogGroup",
                    "logs:CreateLogStream",
                    "logs:PutLogEvents"
                ],
                Resource = "arn:aws:logs:*:*:*"
            }
        ]
    })
}

resource "aws_iam_policy" "website-lambda-policy-dynamodb-put" {
    name = "website-lambda-policy-dynamodb-put"
    policy = jsonencode({
        Version = "2012-10-17",
        Statement = [
            {
                Effect = "Allow",
                Action = [
                    "dynamodb:PutItem",
                    "dynamodb:UpdateItem"
                ],
                Resource = aws_dynamodb_table.website-tracking-table.arn
            }
        ]
    })
}

resource "aws_iam_policy" "website-lambda-policy-dynamodb-get" {
    name = "website-lambda-policy-dynamodb-get"
    policy = jsonencode({
        Version = "2012-10-17",
        Statement = [
            {
                Effect = "Allow",
                Action = [
                    "dynamodb:Query"
                ],
                Resource = "arn:aws:dynamodb:*:*:table/${aws_dynamodb_table.website-tracking-table.name}/index/FingerprintIndex"
            }
        ]
    })
} 

resource "aws_iam_role_policy_attachment" "website-lambda-policy-cloudwatch-put-attachment" {
    policy_arn = aws_iam_policy.website-lambda-policy-cloudwatch.arn
    role = aws_iam_role.website-lambda-role-put.name
}

resource "aws_iam_role_policy_attachment" "website-lambda-policy-cloudwatch-get-attachment" {
    policy_arn = aws_iam_policy.website-lambda-policy-cloudwatch.arn
    role = aws_iam_role.website-lambda-role-get.name
}

resource "aws_iam_role_policy_attachment" "website-lambda-policy-dynamodb-put-attachment" {
    policy_arn = aws_iam_policy.website-lambda-policy-dynamodb-put.arn
    role = aws_iam_role.website-lambda-role-put.name
}

resource "aws_iam_role_policy_attachment" "website-lambda-policy-dynamodb-get-attachment" {
    policy_arn = aws_iam_policy.website-lambda-policy-dynamodb-get.arn
    role = aws_iam_role.website-lambda-role-get.name
}
