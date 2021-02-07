import requests
import json
from api import send_notifications

headers = {
    'Content-Type': 'application/json',
    'Authorization': 'key=' + serverToken,
}

# notification_body = send_notifications()
# print(notification_body)
# if notification_body:
#     print (notification_body)
body = {
        'notification': {
            'title': 'Your Fridge Misses You',
            'body': "Your Octopus is about to expire, checkout these cool recipes"
        },
        'to': deviceToken,
        'priority': 'high',
}
response = requests.post("https://fcm.googleapis.com/fcm/send",headers = headers, data=json.dumps(body))
print(response.status_code)
print(response.json())