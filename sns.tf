resource "aws_sns_topic" "topic" {
  name = "s3-event-notification-topic"

  policy = <<POLICY
{
    "Version":"2012-10-17",
    "Statement":[{
        "Effect": "Allow",
        "Principal": { "Service": "s3.amazonaws.com" },
        "Action": "SNS:Publish",
        "Resource": "arn:aws:sns:*:*:s3-event-notification-topic",
        "Condition":{
            "ArnLike":{"aws:SourceArn":"${aws_s3_bucket.maczbucket1.arn}"}
        }
    }]
}
POLICY
}

############## aws_sns_topic_notification #################
resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = aws_s3_bucket.maczbucket1.id
  topic {
    topic_arn     = aws_sns_topic.topic.arn
    events        = ["s3:ObjectCreated:*"]
  }
}

############## aws_sns_topic_subscription #################
resource "aws_sns_topic_subscription" "email-target2" {
  topic_arn = aws_sns_topic.topic.arn
  protocol  = "email"
  endpoint  = "makarios059@gmail.com"
}
