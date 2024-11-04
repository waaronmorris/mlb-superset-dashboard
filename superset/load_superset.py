import requests

SUPERSET_URL = 'http://localhost:8088'

url = '{0}/api/v1/security/login'.format(SUPERSET_URL)
payload = {'username': 'admin', 'password': 'admin'}
response = requests.post(url, data=payload)
ACCESS_TOKEN = response.json()['access_token']

url = '{0}/api/v1/import_dashboards'.format(SUPERSET_URL)
headers = {'Authorization': 'Bearer <access_token>'}
body = {'overwrite': True}
files = {'dashboard_file': open('../superset/assets/dataset_import.zip', 'rb')}

response = requests.post(url, headers=headers, files=files)
print(response.text)
