import firebase_admin
from firebase_admin import credentials, firestore
import os

cred = credentials.Certificate(os.getenv('FridgoTopia'))
firebase_admin.initialize_app(cred, {
  'projectId': 'frigotopia-edaa2',
})

db = firestore.client()

LIMIT = 1


def get_fridge_contents(fridgeId, page):
    # Offset is not good for scaling and pricing (counts as query)
    # Ok for hackathon, change after
    fridge_ref = (db.collection(f"fridge/{fridgeId}/items")
                    .offset(LIMIT * int(page))
                    .limit(LIMIT)
                    .get())
    
    fridge_items = []
    for item in fridge_ref:
        fridge_items.append(item.to_dict())  


    return fridge_items



def get_expiring_items():
    print("made it this far")
    # Offset is not good for scaling and pricing (counts as query)
    # Ok for hackathon, change after
    fridge_ref = (db.collection("fridge/jCWuzPNfKdw1MKztfzSI/items")
                    .get())
    
    fridge_items = []
    for item in fridge_ref:
        fridge_items.append(item.to_dict())  

    return fridge_items


def addFridge(user):
    print('Not impplemented yet...')

def addItem(fridge_id, item):
    fridge = db.collection('fridge').document(fridge_id)
    if not fridge.get().to_dict():
        return

    # generate the id
    doc_ref = fridge.collection('items').document()
    # populate the document
    doc_ref.set(item)    

    # set the itemId on the item
    doc = doc_ref.get().to_dict()
    doc['itemId'] = doc_ref.id
    return doc

def removeItem(fridge_id, item_id):
    fridge = db.collection('fridge').document(fridge_id)
    if not fridge.get().to_dict():
        return

    fridge.collection('items').document(item_id).delete()



def getFridgeRefFromUser(user):
    user_ref = db.collection('user').document(user).get().to_dict()

    if not user_ref:
        return 
    
    fridgeId = user_ref.get('fridgeDoc').id

    if not fridgeId:
        return
    
    return db.collection('fridge').document(fridgeId)

    
#itemData = getFridge('3CQHGX0OkWafpgrkxsO2OfjjDj52')
# for item in itemData:
#         print (item)

# addItem('3CQHGX0OkWafpgrkxsO2OfjjDj52',{"name": "Chicken", "expiryDate": "2021-02-10", "qty": 1, "weight": 3, "price": 5} )
# items = ['chicken', 'tortilla']
# print(items)
# db.collection('fridge').document('testFridge').collection('items').document('item')
