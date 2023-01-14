import boto3
import json
# Create an SQS client
sqs = boto3.client('sqs')
s3 = boto3.client('s3')

sqs2 = boto3.resource('sqs')
queue = sqs2.get_queue_by_name(QueueName='My-first-Queue')
queue_url = queue.url

while True:
    response = sqs.receive_message(QueueUrl=queue_url, MaxNumberOfMessages=1 ,WaitTimeSeconds=20)
    messages = response.get('Messages', [])
    
    if not messages:
        continue
    message = messages[0]
    print(message)
    body = json.loads(message['Body'])
    receipt_handle = message['ReceiptHandle']
    message_body = json.loads(body["Message"])
    record = message_body["Records"][0]

    bucket_name = record["s3"]["bucket"]["name"]
    file_name = record["s3"]["object"]["key"]
    print(bucket_name)
    print(file_name)
    s3.download_file(bucket_name, file_name, f'/home/mac/Desktop/SKS_SQS_microservis/{file_name}')
    # Delete the message from the queue
    sqs.delete_message(QueueUrl=queue_url, ReceiptHandle=receipt_handle)

    with open(f'{file_name}', 'r') as f:
        data = f.read()
        data = data.replace(',', '\n')

    with open(f'{file_name}', 'w') as f:
        f.write(data)

    s3.upload_file(file_name, 'maczbucket2', file_name )