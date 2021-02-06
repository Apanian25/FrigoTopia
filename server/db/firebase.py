import firebase_admin
from firebase_admin import credentials, firestore
import os

cred = credentials.Certificate(os.getenv('FridgoTopia'))
firebase_admin.initialize_app(cred, {
  'projectId': 'frigotopia-edaa2',
})

db = firestore.client()


def getFridge(user):
    user_ref = db.collection('user').document(user).get().to_dict()

    if not user_ref:
        return 
    
    fridgeId = user_ref.get('fridgeDoc').id

    if not fridgeId:
        return

    doc = db.collection('fridge').document(fridgeId).get()

    # print(f'{doc.id} => {doc.to_dict()}')
    items = doc.to_dict().get('items')

    itemData = []
    for item in items:
        print(item.id)
        itemData.append(db.collection('item').document(item.id).get().to_dict())

    return itemData

def addFridge(user):
    print('Not impplemented yet...')

def addItem(user, item):
    db.collection('item').document(user + item['name']).set(item)
    return item

def removeItem(user):
    db.collection('item').document(user).delete()
    
itemData = getFridge('3CQHGX0OkWafpgrkxsO2OfjjDj52')
for item in itemData:
        print (item)

# addItem('3CQHGX0OkWafpgrkxsO2OfjjDj52',{"name": "Chicken", "expiryDate": "2021-02-10", "qty": 1, "weight": 3, "price": 5} )
# items = ['chicken', 'tortilla']
# print(items)
# db.collection('fridge').document('testFridge').collection('items').document('item')
