# SNS-SQS

![sqs sns](https://user-images.githubusercontent.com/28235504/212331414-5c6615ab-2366-415a-8b8e-8567118160ab.jpg)

- 1 - create s3 bucket
- 2 - create sns topic and add access policy to allow s3 events
- 3 - create email subscription with filter policy to allow messages with key called type=email
- 4 - configure event notification on s3 with the sns topic
- 5 - create 3 sqs queues (one of them should be configured as deadletter queue)
- 6 - subscribe sqs queues(except dead lettter one) to the sns topic
- 7 - create python script called validator.py that pull messages from one of the sqs queues and download the file from s3 and change the comma separation to new lines<br>
```
example:
original file:mahmoud,ahmed,mohamed
after change:
mahmoud
ahmed
mohamed
```

the script should upload the file again with the same name with  to different folder in s3 bucket
- 8 - create another python script called metadata.py that pull messages from the other sqs queue and store the file metadata in csv file locally
- 9 - both scripts should pull messages from queues every minute
- 10 - add sleep time in one of the scripts higher than visibility timeout to test the deadletter queue
![image](https://user-images.githubusercontent.com/28235504/212503723-cdc13f8c-4ffa-429c-8669-a0f54a9f8ccf.png)
