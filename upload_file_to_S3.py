import boto3
s3 = boto3.resource('s3')
s3.meta.client.upload_file('/home/mac/Documents/file-mac.txt', 'maczbucket1', 'text_file.txt')
print ("file uploaded successfully")
