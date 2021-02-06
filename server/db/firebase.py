import firebase_admin
from firebase_admin import credentials, firestore
import os

cred = credentials.Certificate(os.getenv('FridgoTopia'))
firebase_admin.initialize_app(cred, {
  'projectId': 'frigotopia-edaa2',
})

db = firestore.client()


def getFridge(user):
    
    fridge = getFridgeRefFromUser(user)
    doc = fridge.get()

    items = doc.to_dict().get('items')

    itemData = []
    for item in items:
        itemData.append(db.collection('item').document(item.id).get().to_dict())

    return itemData

def addFridge(user):
    print('Not impplemented yet...')

def addItem(user, item):
    # add to item collection
    db.collection('item').document(user + item['name']).set(item)

    # add item to the array in the fridge
    fridge = getFridgeRefFromUser(user)
    fridge.update({'items': firestore.ArrayUnion([db.collection('item').document(user + item['name'])])})

    return item

def removeItem(user, name):
    #remove item from fridge array
    fridge = getFridgeRefFromUser(user)
    fridge.update({'items': firestore.ArrayRemove([db.collection('item').document(user + name)])})

    # remove item from item collection
    db.collection('item').document(user).delete()



def getFridgeRefFromUser(user):
    user_ref = db.collection('user').document(user).get().to_dict()

    if not user_ref:
        return 
    
    fridgeId = user_ref.get('fridgeDoc').id

    if not fridgeId:
        return
    
    return db.collection('fridge').document(fridgeId)

    
itemData = getFridge('3CQHGX0OkWafpgrkxsO2OfjjDj52')
# for item in itemData:
#         print (item)

# addItem('3CQHGX0OkWafpgrkxsO2OfjjDj52',{"name": "Chicken", "expiryDate": "2021-02-10", "qty": 1, "weight": 3, "price": 5} )
# items = ['chicken', 'tortilla']
# print(items)
# db.collection('fridge').document('testFridge').collection('items').document('item')
