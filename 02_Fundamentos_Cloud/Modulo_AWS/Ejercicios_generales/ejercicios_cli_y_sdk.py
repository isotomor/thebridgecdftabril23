import boto3
import json

s3 = boto3.client('s3')

# Specify the bucket name and file name
bucket= 'your bucket name'
key = 'file.json'

#Get the json file from S3, load the body of the file and print it
obj = s3.get_object(Bucket=bucket, Key=key)
json_data = json.loads(obj['Body'].read().decode('utf-8'))
print("Original data:", json_data)

# Modify the JSON data
json_data['new_key'] = 'New Value'

# Convert the updated JSON data back to a string
updated_json_data = json.dumps(json_data)

# Write the updated JSON data back to the S3 bucket
s3.put_object(Body=updated_json_data, Bucket=bucket, Key=key)

# Print the updated JSON data
print("Updated data:", updated_json_data)
