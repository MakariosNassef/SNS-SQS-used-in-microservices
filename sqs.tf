resource "aws_sqs_queue" "terraform_first_queue" {
  name = "My-first-Queue"

  visibility_timeout_seconds = 300
}
resource "aws_sqs_queue_policy" "test" {
  queue_url = aws_sqs_queue.terraform_first_queue.id

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "sqspolicy",
  "Statement": [
    {
      "Sid": "First",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "sqs:SendMessage",
      "Resource": "${aws_sqs_queue.terraform_first_queue.arn}",
      "Condition": {
        "ArnEquals": {
          "aws:SourceArn": "${aws_sns_topic.topic.arn}"
        }
      }
    }
  ]
}
POLICY
}

resource "aws_sqs_queue" "terraform_secound_queue" {
  name = "My-secound-Queue"
  visibility_timeout_seconds = 300
}

resource "aws_sqs_queue_policy" "secPolice" {
  queue_url = aws_sqs_queue.terraform_secound_queue.id

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "sqspolicy",
  "Statement": [
    {
      "Sid": "First",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "sqs:SendMessage",
      "Resource": "${aws_sqs_queue.terraform_secound_queue.arn}",
      "Condition": {
        "ArnEquals": {
          "aws:SourceArn": "${aws_sns_topic.topic.arn}"
        }
      }
    }
  ]
}
POLICY
}

############ SNS subscribtion #####################################################

######## SNS subscribtion  for first_sqs_target ##########
resource "aws_sns_topic_subscription" "first_sqs_target" {
  topic_arn = aws_sns_topic.topic.arn
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.terraform_first_queue.arn
}

######## SNS subscribtion  for secound_sqs_target #########
resource "aws_sns_topic_subscription" "secound_sqs_target" {
  topic_arn = aws_sns_topic.topic.arn
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.terraform_secound_queue.arn
}