
resource "aws_cloudwatch_metric_alarm" "high_requests" {
    alarm_name          = "HighRequestsInCloudFront"
    comparison_operator = "GreaterThanThreshold"
    evaluation_periods  = "1"
    metric_name         = "Requests"
    namespace           = "AWS/CloudFront"
    period              = "3600"
    statistic           = "Sum"
    threshold           = "100"
    alarm_description   = "This alarm triggers when there are more than 100 requests in one hour."
    dimensions = {
        DistributionId = aws_cloudfront_distribution.website-cloudfront-distribution.id
    }

    alarm_actions = [
        aws_sns_topic.website-cloudwatch-alarms.arn
    ]

    ok_actions = [
        aws_sns_topic.website-cloudwatch-alarms.arn
    ]
}

resource "aws_cloudwatch_metric_alarm" "high_total_error_rate" {
    alarm_name          = "HighTotalErrorRateInCloudFront"
    comparison_operator = "GreaterThanThreshold"
    evaluation_periods  = "2"
    metric_name         = "TotalErrorRate"
    namespace           = "AWS/CloudFront"
    period              = "300"
    statistic           = "Sum"
    threshold           = "25"
    alarm_description   = "This alarm triggers if the total error rate surpasses 25% over 5 minutes"
    dimensions = {
        DistributionId = aws_cloudfront_distribution.website-cloudfront-distribution.id
    }

    alarm_actions = [
        aws_sns_topic.website-cloudwatch-alarms.arn
    ]

    ok_actions = [
        aws_sns_topic.website-cloudwatch-alarms.arn
    ]
}

resource "aws_cloudwatch_metric_alarm" "high_4xx_error_rate" {
    alarm_name          = "High4xxErrorRateInCloudFront"
    comparison_operator = "GreaterThanThreshold"
    evaluation_periods  = "2"
    metric_name         = "4xxErrorRate"
    namespace           = "AWS/CloudFront"
    period              = "300"
    statistic           = "Sum"
    threshold           = "25"
    alarm_description   = "This alarm triggers if the 4xx error rate surpasses 25% over 5 minutes"
    dimensions = {
        DistributionId = aws_cloudfront_distribution.website-cloudfront-distribution.id
    }

    alarm_actions = [
        aws_sns_topic.website-cloudwatch-alarms.arn
    ]

    ok_actions = [
        aws_sns_topic.website-cloudwatch-alarms.arn
    ]
}

resource "aws_cloudwatch_metric_alarm" "high_5xx_error_rate" {
    alarm_name          = "High5xxErrorRateInCloudFront"
    comparison_operator = "GreaterThanThreshold"
    evaluation_periods  = "2"
    metric_name         = "5xxErrorRate"
    namespace           = "AWS/CloudFront"
    period              = "300"
    statistic           = "Sum"
    threshold           = "25"
    alarm_description   = "This alarm triggers if the 5xx error rate surpasses 25% over 5 minutes"
    dimensions = {
        DistributionId = aws_cloudfront_distribution.website-cloudfront-distribution.id
    }

    alarm_actions = [
        aws_sns_topic.website-cloudwatch-alarms.arn
    ]

    ok_actions = [
        aws_sns_topic.website-cloudwatch-alarms.arn
    ]
}

resource "aws_cloudwatch_metric_alarm" "high_lambda_duration_track" {
    alarm_name          = "HighLambdaDuration TrackingLambda"
    comparison_operator = "GreaterThanThreshold"
    evaluation_periods  = "1"
    metric_name         = "Duration"
    namespace           = "AWS/Lambda"
    period              = "300"
    statistic           = "Average"
    threshold           = "3000"
    alarm_description   = "This alarm triggers if the average duration exceeds 3000 ms over 5 minutes"
    dimensions = {
        FunctionName = aws_lambda_function.website-lambda-track.function_name,
    }

    alarm_actions = [
        aws_sns_topic.website-cloudwatch-alarms.arn
    ]

    ok_actions = [
        aws_sns_topic.website-cloudwatch-alarms.arn
    ]
}

resource "aws_cloudwatch_metric_alarm" "high_lambda_throttles_track" {
    alarm_name          = "HighLambdaThrottles TrackingLambda"
    comparison_operator = "GreaterThanThreshold"
    evaluation_periods  = "1"
    metric_name         = "Throttles"
    namespace           = "AWS/Lambda"
    period              = "300"
    statistic           = "Sum"
    threshold           = "1"
    alarm_description   = "This alarm triggers if there is more than 1 throttle in 5 minutes"
    dimensions = {
        FunctionName = aws_lambda_function.website-lambda-track.function_name
    }

    alarm_actions = [
        aws_sns_topic.website-cloudwatch-alarms.arn
    ]

    ok_actions = [
        aws_sns_topic.website-cloudwatch-alarms.arn
    ]
}

resource "aws_cloudwatch_metric_alarm" "high_lambda_errors_track" {
    alarm_name          = "HighLambdaErrors TrackingLambda"
    comparison_operator = "GreaterThanThreshold"
    evaluation_periods  = "1"
    metric_name         = "Errors"
    namespace           = "AWS/Lambda"
    period              = "300"
    statistic           = "Sum"
    threshold           = "5"
    alarm_description   = "This alarm triggers if there are more than 5 errors in 5 minutes"
    dimensions = {
        FunctionName = aws_lambda_function.website-lambda-track.function_name
    }

    alarm_actions = [
        aws_sns_topic.website-cloudwatch-alarms.arn
    ]

    ok_actions = [
        aws_sns_topic.website-cloudwatch-alarms.arn
    ]
}

resource "aws_cloudwatch_metric_alarm" "high_lambda_duration_donottrack" {
    alarm_name          = "HighLambdaDuration DoNotTrackLambda"
    comparison_operator = "GreaterThanThreshold"
    evaluation_periods  = "1"
    metric_name         = "Duration"
    namespace           = "AWS/Lambda"
    period              = "300"
    statistic           = "Average"
    threshold           = "3000"
    alarm_description   = "This alarm triggers if the average duration exceeds 3000 ms over 5 minutes"
    dimensions = {
        FunctionName = aws_lambda_function.website-lambda-donottrack.function_name,
    }

    alarm_actions = [
        aws_sns_topic.website-cloudwatch-alarms.arn
    ]

    ok_actions = [
        aws_sns_topic.website-cloudwatch-alarms.arn
    ]
}

resource "aws_cloudwatch_metric_alarm" "high_lambda_throttles_donottrack" {
    alarm_name          = "HighLambdaThrottles DoNotTrackLambda"
    comparison_operator = "GreaterThanThreshold"
    evaluation_periods  = "1"
    metric_name         = "Throttles"
    namespace           = "AWS/Lambda"
    period              = "300"
    statistic           = "Sum"
    threshold           = "1"
    alarm_description   = "This alarm triggers if there is more than 1 throttle in 5 minutes"
    dimensions = {
        FunctionName = aws_lambda_function.website-lambda-donottrack.function_name
    }

    alarm_actions = [
        aws_sns_topic.website-cloudwatch-alarms.arn
    ]

    ok_actions = [
        aws_sns_topic.website-cloudwatch-alarms.arn
    ]
}

resource "aws_cloudwatch_metric_alarm" "high_lambda_errors_donottrack" {
    alarm_name          = "HighLambdaErrors DoNotTrackLambda"
    comparison_operator = "GreaterThanThreshold"
    evaluation_periods  = "1"
    metric_name         = "Errors"
    namespace           = "AWS/Lambda"
    period              = "300"
    statistic           = "Sum"
    threshold           = "5"
    alarm_description   = "This alarm triggers if there are more than 5 errors in 5 minutes"
    dimensions = {
        FunctionName = aws_lambda_function.website-lambda-donottrack.function_name
    }

    alarm_actions = [
        aws_sns_topic.website-cloudwatch-alarms.arn
    ]

    ok_actions = [
        aws_sns_topic.website-cloudwatch-alarms.arn
    ]
}

resource "aws_cloudwatch_metric_alarm" "high_lambda_duration_trackedactions" {
    alarm_name          = "HighLambdaDuration TrackedActionsLambda"
    comparison_operator = "GreaterThanThreshold"
    evaluation_periods  = "1"
    metric_name         = "Duration"
    namespace           = "AWS/Lambda"
    period              = "300"
    statistic           = "Average"
    threshold           = "3000"
    alarm_description   = "This alarm triggers if the average duration exceeds 3000 ms over 5 minutes"
    dimensions = {
        FunctionName = aws_lambda_function.website-lambda-trackedactions.function_name,
    }

    alarm_actions = [
        aws_sns_topic.website-cloudwatch-alarms.arn
    ]

    ok_actions = [
        aws_sns_topic.website-cloudwatch-alarms.arn
    ]
}

resource "aws_cloudwatch_metric_alarm" "high_lambda_throttles_trackedactions" {
    alarm_name          = "HighLambdaThrottles TrackedActionsLambda"
    comparison_operator = "GreaterThanThreshold"
    evaluation_periods  = "1"
    metric_name         = "Throttles"
    namespace           = "AWS/Lambda"
    period              = "300"
    statistic           = "Sum"
    threshold           = "1"
    alarm_description   = "This alarm triggers if there is more than 1 throttle in 5 minutes"
    dimensions = {
        FunctionName = aws_lambda_function.website-lambda-trackedactions.function_name
    }

    alarm_actions = [
        aws_sns_topic.website-cloudwatch-alarms.arn
    ]

    ok_actions = [
        aws_sns_topic.website-cloudwatch-alarms.arn
    ]
}

resource "aws_cloudwatch_metric_alarm" "high_lambda_errors_trackedactions" {
    alarm_name          = "HighLambdaErrors TrackedActionsLambda"
    comparison_operator = "GreaterThanThreshold"
    evaluation_periods  = "1"
    metric_name         = "Errors"
    namespace           = "AWS/Lambda"
    period              = "300"
    statistic           = "Sum"
    threshold           = "5"
    alarm_description   = "This alarm triggers if there are more than 5 errors in 5 minutes"
    dimensions = {
        FunctionName = aws_lambda_function.website-lambda-trackedactions.function_name
    }

    alarm_actions = [
        aws_sns_topic.website-cloudwatch-alarms.arn
    ]

    ok_actions = [
        aws_sns_topic.website-cloudwatch-alarms.arn
    ]
}

resource "aws_cloudwatch_metric_alarm" "high_dynamodb_errors" {
    alarm_name          = "HighDynamoDBErrors"
    comparison_operator = "GreaterThanThreshold"
    evaluation_periods  = "1"
    metric_name         = "Errors"
    namespace           = "AWS/DynamoDB"
    period              = "300"
    statistic           = "Sum"
    threshold           = "1"
    alarm_description   = "This alarm triggers if there is more than 1 error in 5 minutes"
    dimensions = {
        TableName = aws_dynamodb_table.website-tracking-table.name
    }

    alarm_actions = [
        aws_sns_topic.website-cloudwatch-alarms.arn
    ]

    ok_actions = [
        aws_sns_topic.website-cloudwatch-alarms.arn
    ]
}

resource "aws_cloudwatch_metric_alarm" "high_dynamodb_throttles" {
    alarm_name          = "HighDynamoDBThrottles"
    comparison_operator = "GreaterThanThreshold"
    evaluation_periods  = "1"
    metric_name         = "ThrottledRequests"
    namespace           = "AWS/DynamoDB"
    period              = "300"
    statistic           = "Sum"
    threshold           = "1"
    alarm_description   = "This alarm triggers if there is more than 1 throttle in 5 minutes"
    dimensions = {
        TableName = aws_dynamodb_table.website-tracking-table.name
    }

    alarm_actions = [
        aws_sns_topic.website-cloudwatch-alarms.arn
    ]

    ok_actions = [
        aws_sns_topic.website-cloudwatch-alarms.arn
    ]
}

resource "aws_cloudwatch_metric_alarm" "high_dynamodb_consumed_capacity" {
    alarm_name          = "HighDynamoDBConsumedCapacity"
    comparison_operator = "GreaterThanThreshold"
    evaluation_periods  = "1"
    metric_name         = "ConsumedWriteCapacityUnits"
    namespace           = "AWS/DynamoDB"
    period              = "300"
    statistic           = "Sum"
    threshold           = "10"
    alarm_description   = "This alarm triggers if the consumed write capacity units exceed 10 in 5 minutes"
    dimensions = {
        TableName = aws_dynamodb_table.website-tracking-table.name
    }

    alarm_actions = [
        aws_sns_topic.website-cloudwatch-alarms.arn
    ]

    ok_actions = [
        aws_sns_topic.website-cloudwatch-alarms.arn
    ]
}