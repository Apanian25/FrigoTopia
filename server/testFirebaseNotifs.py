import requests
import json
from api import send_notifications

serverToken = 'AAAA8K7fqDU:APA91bEw2Hq-De-YlzBtMBw1srUuNudhzNd2vsR-mqtr-uUmyrHVnY4_9lQTtYS_zeSndtaRt3ib6OA0lHztVx0Iymz3waMwMcI4wreWNXW12FKCunYEuibJkXykRvn7ooWX9EZct9ek'
deviceToken = 'eOGElNpkTs6So7EYq0SnBz:APA91bHmK5EaAhaBJG798jIfThYIFneIC4J8O5X5TRTY15LY8_sB16niIXYcDu5arFB35ytmnOEDtgGxG08nm7jrMr2JLPNl84EYsf27GzEsvCiWTwu8k0gIHAQ29ZzmRsXdzAKa_2wJ'

headers = {
    'Content-Type': 'application/json',
    'Authorization': 'key=' + serverToken,
}

notification_body = send_notifications()
print(notification_body)
if notification_body:
    print (notification_body)
    body = {
            'notification': {
                'title': 'Your Fridge Misses You',
                'body': notification_body
            },
            'to': deviceToken,
            'priority': 'high',
    }
    response = requests.post("https://fcm.googleapis.com/fcm/send",headers = headers, data=json.dumps(body))
    print(response.status_code)
    print(response.json())