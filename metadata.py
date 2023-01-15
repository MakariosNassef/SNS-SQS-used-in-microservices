import boto3
import csv
import time
# Create SQS client
sqs = boto3.resource('sqs')
sqs2 = boto3.client('sqs')
s3 = boto3.resource('s3')
queue = sqs.get_queue_by_name(QueueName='My-secound-Queue')

while True:

    # Receive message from SQS queue
    response = sqs2.receive_message(QueueUrl=queue.url, MaxNumberOfMessages=10,WaitTimeSeconds=20)
    try:

        # Get the file metadata from the message body and store it in a CSV file locally 
        messages = response['Messages']
        message = messages[0]
        receipt_handle = message['ReceiptHandle']

        for message in messages:

            body = message['Body']

            with open('metadata.csv', 'a+', newline='') as csvfile:

                writer = csv.writer(csvfile)

                writer.writerow([body])
                
            time.sleep(600)
            # Delete received message from queue 
            sqs2.delete_message(QueueUrl=queue.url, ReceiptHandle=receipt_handle)
            print(body)
            print ("messages from the sqs queue and store successfully")

    except KeyError:  # If no messages are available, do nothing 

        pass



