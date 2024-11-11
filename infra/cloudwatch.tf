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
        aws_sns_topic.website-cloudfront-alarms.arn
    ]

    ok_actions = [
        aws_sns_topic.website-cloudfront-alarms.arn
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
        aws_sns_topic.website-cloudfront-alarms.arn
    ]

    ok_actions = [
        aws_sns_topic.website-cloudfront-alarms.arn
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
        aws_sns_topic.website-cloudfront-alarms.arn
    ]

    ok_actions = [
        aws_sns_topic.website-cloudfront-alarms.arn
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
        aws_sns_topic.website-cloudfront-alarms.arn
    ]

    ok_actions = [
        aws_sns_topic.website-cloudfront-alarms.arn
    ]
}