import requests, json

BASE = "http://127.0.0.1:3000/"


data = [
    {"name": "Chicken", "expiryDate": "2021-02-10", "qty": 1, "weight": 3, "price": 5},
    {"name": "Banana", "expiryDate": "2021-02-10", "qty": 3, "weight": 1, "price": 2},
    {"name": "Apple", "expiryDate": "2021-02-10", "qty": 5, "weight": 2, "price": 3},
    {"name": "Orange", "expiryDate": "2021-02-10", "qty": 2, "weight": 3, "price": 2},
]

# response = requests.get(BASE + "api/v1/items?page=0")
# print(response.json())

# for i in range(len(data)):
#     response = requests.put(BASE + "api/v1/modify/items/jCWuzPNfKdw1MKztfzSI", data[i])
#     print(response.json())

response = requests.put(BASE + "api/v1/modify/items", data[0])
print(response.json())

# response = requests.delete(BASE + "api/v1/modify/items", data={'itemId': '6ziGPSjc3m4P7OG06V9Z'})
# print(response)
