import boto3

dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('cf_assets')

table.put_item(
   Item={
       'ticker': 'BTC-GBP',
       'name': 'Bitcoin',
       'quantity': 1,
       'type': 'crypto',
    }
)

table.put_item(
   Item={
       'ticker': 'ETH-GBP',
       'name': 'Ethereum',
       'quantity': 5,
       'type': 'crypto',
    }
)

table.put_item(
   Item={
       'ticker': 'AMZN',
       'name': 'Amazon',
       'quantity': 1,
       'type': 'equity',
       'currency': 'USD',
    }
)

table.put_item(
   Item={
       'ticker': 'MSFT',
       'name': 'Microsoft',
       'quantity': 2,
       'type': 'equity',
       'currency': 'USD',
    }
)

table.put_item(
   Item={
       'ticker': 'LSEG.L',
       'name': 'London Stock Exchange Group',
       'quantity': 1,
       'type': 'equity',
       'currency': 'GBP',
    }
)
