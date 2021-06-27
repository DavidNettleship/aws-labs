import boto3
import yfinance as yf
import time
from datetime import date


def scanner():
    dynamodb = boto3.resource('dynamodb')
    table = dynamodb.Table('cf_assets')
    scan = table.scan()
    cf_assets = scan['Items']
    return cf_assets


def fetch_assets(cf_assets):
    data = []
    for asset in cf_assets:

        if asset['type'] == 'equity':
            ticker = asset['ticker']
            asset_type = asset['type']
            quant = asset['quantity']
            currency = asset['currency']
            vals = {'ticker': ticker, 'type': asset_type, 'quantity': quant, 'currency': currency}
            data.append(vals)

        else:
            ticker = asset['ticker']
            asset_type = asset['type']
            quant = asset['quantity']
            vals = {'ticker': ticker, 'type': asset_type, 'quantity': quant}
            data.append(vals)

    return data


def value_assets(data):
    val_data = []
    for asset in data:
        #get last close price
        ticker = asset['ticker']
        df = yf.download(ticker,period = "1d")
        close = (df.iloc[0]['Close'])

        #calculate aprox values
        if asset['type'] == 'equity':

            #GBP stocks denominated in pennies, divide by 100
            if asset['currency'] == 'GBP':
                value = round((close*float(asset['quantity'])/100),2)

            #USD stocks - get exchange rate & convert
            elif asset['currency'] == 'USD':
                fx_df = yf.download('GBPUSD=X', period="1d")
                fx_close = (fx_df.iloc[0]['Close'])
                value = round(((close*float(asset['quantity']))/float(fx_close)),2)
            
            #TODO
            #create a more generic forex conversion function!
            else:
                value = round(close*float(asset['quantity']),2)

        else:
            value = round(close*float(asset['quantity']),2)

        vals = {'ticker': ticker, 'value': value}
        val_data.append(vals)

    return val_data


def write_history(data):
    dynamodb = boto3.resource('dynamodb')
    table = dynamodb.Table('cf_historical_values')
    ts = time.time()
    dat = date.today()
    d = dat.strftime("%d-%b-%Y")

    for asset in data:
        table.put_item(
            Item={
                'id': asset['ticker']+str(ts),
                'date': str(d),
                'ticker': asset['ticker'],
                'value': str(asset['value']),
                }
            )


def main():
    cf_assets = scanner()
    data = fetch_assets(cf_assets)
    val_data = value_assets(data)
    print(val_data)
    #write_history(val_data)


main()
