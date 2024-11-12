import json
import boto3
import os
import logging
from boto3.dynamodb.conditions import Key
import ast
import decimal

logger = logging.getLogger()
logger.setLevel(logging.INFO)

class DecimalEncoder(json.JSONEncoder):
    def default(self, o):
        if isinstance(o, decimal.Decimal):
            if o % 1 > 0:
                return float(o)
            else:
                return int(o)
        return super(DecimalEncoder, self).default(o)

def get_from_dynamodb(data):
    try:
        dynamodb = boto3.resource('dynamodb')
        table = dynamodb.Table(os.environ['TABLE_NAME'])
        response = table.query(
            IndexName=os.environ['INDEX_NAME'],
            KeyConditionExpression=Key('Fingerprint').eq(data['fingerprint']),
            ProjectionExpression='Fingerprint, Actions',
            Limit=100
        )
        
        if response['Count'] == 0:
            return None
        
        logger.info(f'Found {response["Count"]} items')
        logger.info(response['Items'])
        
        res = []

        for item in response['Items']:
            res.append(ast.literal_eval((
                json.dumps(item, cls=DecimalEncoder)
            )))

        return res
    
    except Exception as e:
        logger.error(e)
        return None

def lambda_handler(event, context):
    logger.info(f'Received new event from {event["requestContext"]["identity"]["sourceIp"]}')
    
    try:
        data = json.loads(event['body'])
        if 'fingerprint' not in data:
            logger.error('Missing fingerprint in the request body')
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

    existing_data = get_from_dynamodb(data)

    if existing_data is None:
        logger.info('No existing data found')
        return {
            'statusCode': 404,
            'body': json.dumps('No existing data found'),
            'headers': {
                'Content-Type': 'application/json'
            }
        }
    
    return {
        'statusCode': 200,
        'body': json.dumps(existing_data),
        'headers': {
            'Content-Type': 'application/json'
        }
    }

