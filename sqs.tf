# This resource block creates an SQS queue called "My-first-Queue"
resource "aws_sqs_queue" "terraform_first_queue" {
  name = "My-first-Queue"
  visibility_timeout_seconds = 15
    redrive_policy    = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.dead_letter_queue.arn
    maxReceiveCount    = 5
  })
}

# This resource block creates an SQS queue called "My-secound-Queue"
resource "aws_sqs_queue" "terraform_secound_queue" {
  name = "My-secound-Queue"
  visibility_timeout_seconds = 300
}

resource "aws_sqs_queue" "dead_letter_queue" {
  name              = "dead-letter-queue"
  visibility_timeout_seconds = 300
}

# This resource block creates an SQS queue policy that allows sending messages to "My-first-Queue"
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

############ SNS subscribtion ############

# subscription for the SQS queue "terraform_first_queue" to the SNS topicresource "aws_sns_topic_subscription" "first_sqs_target" {
  topic_arn = aws_sns_topic.topic.arn
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.terraform_first_queue.arn
}

# subscription for the SQS queue "terraform_secound_queue" to the SNS topicresource "aws_sns_topic_subscription" "secound_sqs_target" {
  topic_arn = aws_sns_topic.topic.arn
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.terraform_secound_queue.arn
}
