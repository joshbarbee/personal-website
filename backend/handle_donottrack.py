import json
import boto3
import os
import logging

logger = logging.getLogger()

def delete_from_dynamodb(fingerprint):
    try:
        dynamodb = boto3.resource('dynamodb')
        table = dynamodb.Table(os.environ['TABLE_NAME'])
        table.batch_writer().delete_item(
            Key={
                'Fingerprint': fingerprint
            }
        )

        return True
    
    except Exception as e:
        logger.error(e)
        return False

def lambda_handler(event, context):
    logger.info(f'Received new event from {event["requestContext"]["identity"]["sourceIp"]}')
    
    try:
        data = json.loads(event['body'])
        if 'fingerprint' not in data:
            logger.error('Missing fingerprintin the request body')
            return {
                'statusCode': 400,
                'body': json.dumps('Missing fingerprint in the request body'),
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

    fingerprint = data['fingerprint']
    if delete_from_dynamodb(fingerprint):
        return {
            'statusCode': 200,
            'body': json.dumps('Successfully deleted fingerprint'),
            'headers': {
                'Content-Type': 'application/json'
            }
        }
    else:
        logger.error('Failed to delete fingerprint')
        return {
            'statusCode': 500,
            'body': json.dumps('Failed to delete fingerprint'),
            'headers': {
                'Content-Type': 'application/json'
            }
        }

