# SNS-SQS

### SNS (Simple Notification Service) and SQS (Simple Queue Service) are both services provided by Amazon Web Services (AWS), but they serve different purposes.

- SNS is a messaging service that allows you to send notifications or messages to multiple subscribers or endpoints. It can be used to send messages via email, SMS, or other messaging protocols. SNS is commonly used for sending event-driven messages, such as sending an email when a user signs up for a service.

- SQS, on the other hand, is a fully managed message queue service that allows you to store and retrieve messages in a queue. SQS is commonly used for decoupling and scaling microservices, serverless applications, and distributed systems. SQS can also be used for storing messages for later processing.

---------------------

- SNS and SQS can be used together to create a more robust architecture. For example, SNS can be used to send a message to SQS, which will then be processed by a worker. SQS can also trigger an SNS topic when a new message is added to the queue.
