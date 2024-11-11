resource "aws_sns_topic" "website-cloudfront-alarms" {
  name = "website-cloudfront-alarms"
}

resource "aws_sns_topic_subscription" "website-cloudfront-alarms-email" {
  topic_arn = aws_sns_topic.website-cloudfront-alarms.arn
  protocol  = "email"
  endpoint  = var.email
}