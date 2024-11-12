import json
import boto3
import os
import time
import uuid
import logging

logger = logging.getLogger()

def send_to_dynamodb(data):
    try:
        dynamodb = boto3.resource('dynamodb')
        table = dynamodb.Table(os.environ['TABLE_NAME'])
        table.put_item(
            Item={
                "UUID": str(uuid.uuid4()),
                'Fingerprint': data['fingerprint'],
                'Actions': data['actions'],
                'Timestamp': int(time.time())
            }
        )
    except Exception as e:
        logger.error(e)
        return False

    return True

def lambda_handler(event, context):
    logger.info(f'Received new event from {event["requestContext"]["identity"]["sourceIp"]}')
    
    try:
        data = json.loads(event['body'])
        if 'fingerprint' not in data or 'actions' not in data:
            logger.error('Missing fingerprint or action in the request body')
            return {
                'statusCode': 400,
                'body': json.dumps('Missing fingerprint or action in the request body'),
                'headers': {
                    'Content-Type': 'application/json'
                }
            }
    except json.JSONDecodeError:
        logger.error('Invalid JSON in the request body')
        return {
            'statusCode': 400,
            'body': json.dumps('Invalid JSON in the request body'),
            'headers': {
                'Content-Type': 'application/json'
            }
        }

    if not send_to_dynamodb(data):
        logger.error('Error saving data to DynamoDB')
        return {
            'statusCode': 500,
            'body': json.dumps('Error saving data to DynamoDB'),
            'headers': {
                'Content-Type': 'application/json'
            }
        }
    
    logger.info('Data saved to DynamoDB')

    return {
        'statusCode': 200,
        'body': json.dumps('Data saved to DynamoDB'),
        'headers': {
            'Content-Type': 'application/json'
        }
    }

