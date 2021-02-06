import requests, json

BASE = "http://127.0.0.1:5000/"


data = [
    {"name": "Chicken", "expiryDate": "2021-02-10", "qty": 1, "weight": 3, "price": 5},
    {"name": "Banana", "expiryDate": "2021-02-10", "qty": 3, "weight": 1, "price": 2},
    {"name": "Apple", "expiryDate": "2021-02-10", "qty": 5, "weight": 2, "price": 3},
    {"name": "Orange", "expiryDate": "2021-02-10", "qty": 2, "weight": 3, "price": 2},
]

# response = requests.get(BASE + "api/v1/items/jCWuzPNfKdw1MKztfzSI")
# print(response)

# for i in range(len(data)):
#     response = requests.put(BASE + "api/v1/modify/items/jCWuzPNfKdw1MKztfzSI", data[i])
#     print(response.json())

response = requests.put(BASE + "api/v1/modify/items/jCWuzPNfKdw1MKztfzSI", data[0])
print(response.json())

response = requests.delete(BASE + "api/v1/modify/items/jCWuzPNfKdw1MKztfzSI", data={'itemId': 'LYn5uflCsJlicZR02h2w'})
print(response)