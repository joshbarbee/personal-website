resource "aws_sns_topic" "website-cloudwatch-alarms" {
  name = "website-cloudwatch-alarms"
}

resource "aws_sns_topic_subscription" "website-cloudwatch-alarms-email" {
  topic_arn = aws_sns_topic.website-cloudwatch-alarms.arn
  protocol  = "email"
  endpoint  = var.email
}