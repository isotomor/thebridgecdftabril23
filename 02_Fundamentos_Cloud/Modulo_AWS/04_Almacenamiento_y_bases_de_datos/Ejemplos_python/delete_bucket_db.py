import logging
import boto3
from botocore.exceptions import ClientError


def delete_bucket(bucket_name):
    """
    Delete s3 bucket
    """

    s3_client = boto3.client('s3')
    s3_client.delete_bucket(Bucket=bucket_name)


if __name__ == "__main__":
    delete_bucket(bucket_name='mi-nuevo-bucket')
