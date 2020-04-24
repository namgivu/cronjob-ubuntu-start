import os

import requests
from datetime import datetime
import tzlocal

def run():
    url = 'https://cccd2c2e-6ef6-465e-b449-51388a0266de.mock.pstmn.io/api/v1/d2c/application/harvest-json'
    input_dict = {
        "azureFileShare": {
            "shareName": "some share name",
            "fileName" : "some file name"
        }
    }
    # headers = { 'Content-Type': 'application/json' }  #TODO do we need this?

    res = requests.post(url=url, json=input_dict)  # res aka response

    if res.status_code == 200:
        return res
    else:
        raise Exception(format_r(res) )


def format_r(r):
    os.environ['TZ'] = 'Asia/Singapore'

    s =''
    s+=f'{datetime.now(tzlocal.get_localzone()).strftime("%Y-%m-%d %H:%M:%S.%f %Z")} \n'  # timestamp with timezone ref. https://stackoverflow.com/a/31304264/248616
    s+=f'  status code {r.status_code} \n'
    s+=f'  reason    - {r.reason} \n'
    s+=f'  text      - {r.text.encode("utf8")} \n'
    return s


if __name__ == '__main__':
    r = run()
    print(format_r(r) )

