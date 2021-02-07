from flask import Flask, request, jsonify
from flask_restful import Api, Resource, reqparse, abort, fields, marshal_with
from db.firebase import get_fridge_contents, addItem, removeItem, get_expiring_items
from YoloDetection import YoloDetection
from FoodInformation import get_food_infomation
from datetime import date, datetime
from imageDetection.receipts.receiptScan import getItems
from RipenessDetection import RipenessDetection
import requests
import numpy as np
import cv2 as cv

app = Flask(__name__)
api = Api(app)

fridge_put_args = reqparse.RequestParser()
fridge_put_args.add_argument("name", type=str, help="Name of the item is required", required=True)
fridge_put_args.add_argument("expiryDate", type=str, help="Expiry date of the item is required", required=True)
fridge_put_args.add_argument("qty", type=str, help="Quantity of item is required", required=True)
fridge_put_args.add_argument("weight", type=int)
fridge_put_args.add_argument("weight", type=int)
fridge_put_args.add_argument("volume", type=int)
fridge_put_args.add_argument("price", type=float)


fridge_delete_args = reqparse.RequestParser()
fridge_delete_args.add_argument("itemId", type=str, help="itemId of the item is required", required=True)


resource_fields = {
    "itemId": fields.String,
    "name": fields.String,
    "expiryDate": fields.String,
    "qty": fields.String,
    "weight": fields.Integer,
    "volume": fields.Integer,
    "price": fields.Integer
}



"""
******************************************************************************
Endpoint: /api/v1/modify/items/:fridge_id

Description: Endpoint that will add or remove items from a fridge

Return: [{name: String, qty: Int, daysLeft: Int}]
******************************************************************************
"""
class Item(Resource):

    @marshal_with(resource_fields)
    def put(self, fridge_id):
        args = fridge_put_args.parse_args()
        result = addItem(fridge_id, args)
        if not result:
            abort(500, message="Something went wrong when adding an item...")

        return result, 201

    @marshal_with(resource_fields)
    def delete(self, fridge_id):
        args = fridge_delete_args.parse_args()
        print('reached')
        removeItem(fridge_id, args['itemId'])
        return {'message':'delete successfully'}, 204 #deleted successfully



"""
******************************************************************************
Endpoint: /api/v1/receipt

Description: 

Return: 
******************************************************************************
"""
class Receipt(Resource):
    def post(self):
        receipt = request.files['image']
        if receipt:
            print('image received')
            items = getItems(receipt)
            json = []
            for item, count in items.items():
                json.append({'name': item, 'qty': count})
            return json
        else:
            print('image not received')
            abort(406, message="No picture detected...")






"""
******************************************************************************
Endpoint: /api/v1/items

Description: Endpoint that will retrieve all of the contents of the fridge in 
a paginated form. 

Return: [{name: String, qty: Int, daysLeft: Int}]
******************************************************************************
"""
#jCWuzPNfKdw1MKztfzSI
@app.route('/api/v1/items', methods=['GET'])
def items():
    # Check if the userId was provided
    if 'fridgeId' not in request.args and 'page' not in request.args:
        return "Error"
    
    fridge_id = request.args['fridgeId']
    page = request.args['page']
    results = get_fridge_contents(fridge_id, page)
    
    formatted_results = []
    
    for result in results:
        expiry_date = datetime.strptime(result['expiryDate'], '%Y-%m-%d').date()
        today = date.today()
        
        formatted_results.append({
                'daysLeft': (expiry_date - today).days,
                'name': result['name'],
                'qty': result['qty']
            })
    
    return jsonify(formatted_results)
    


"""
******************************************************************************
Endpoint: /api/v1/image_upload

Description: Endpoint accepts as a parameter an image and it will then detect 
all the food items present within the image. The function will return a list
of all the items with the quantity, expected expiry date and confidence level

Return: [{name: String, qty: Int, expiryDate: "YYYY-MM-DD", confidence: Int}]
******************************************************************************
"""
# Constant
food_items = ['banana', 'apple', 'sandwich', 'orange', 'broccoli', 'carrot', 
              'hot dog', 'pizza', 'donut', 'cake']
image_detector = YoloDetection()
ripeness_detector = RipenessDetection()

@app.route('/api/v1/image_upload', methods=['POST'])
def items_from_image():
    try:
        imagefile = request.files['image']
    except Exception as err:
        return str(err)
        
    # convert string of image data to uint8
    nparr = np.fromstring(imagefile.read(), np.uint8)
    # decode image
    img = cv.imdecode(nparr, cv.IMREAD_COLOR)
    
    # img = cv.imread(imagefile)
    foods = image_detector.getObjects(img)
    
    parsed_food = {}
    
    for food in foods:
        label = food['label']
        confidence = food['confidence']
        
        if (label not in food_items):
            continue
        
        if (label in parsed_food):
            total_confidence = parsed_food[label]['confidence']
            qty = parsed_food[label]['qty']
            
            parsed_food[label]['confidence'] = ((total_confidence * qty) + confidence)/(qty + 1)
            parsed_food[label]['qty'] += 1
        else:
            if label == 'banana':
                ripeness = ripeness_detector.get_ripeness(img)
            else: 
                ripeness = None
                
            lifetime, tip = get_food_infomation(label, ripeness)
            
            parsed_food[label] = {
                                    'name': label,
                                    'qty': 1,
                                    'confidence': confidence,
                                    'expiryDate': lifetime,
                                    'tip': tip
                                 }
            
    
    return jsonify(list(parsed_food.values()))



"""
******************************************************************************
Endpoint: /api/v1/recipe

Description: Endpoint that will retrieve recipes for a given food item

Return: [{img: String, title: String, src: String, url: String}]
******************************************************************************
"""
url = "https://edamam-recipe-search.p.rapidapi.com/search"

headers = {
    'x-rapidapi-key': "12a97c0bbbmshaf65c2b7355968bp1b19e7jsn55344496d90e",
    'x-rapidapi-host': "edamam-recipe-search.p.rapidapi.com"
    }


@app.route('/api/v1/recipe', methods=['GET'])
def recipes_for_item():
    # Check if the userId was provided
    if 'item' not in request.args and 'page' not in request.args:
        return "Error"
    
    response = requests.request("GET", url, headers=headers, params={"q": request.args['item']})
    recipes = response.json()['hits']
    
    formatted_recipes = []
    
    for recipe in recipes:
        recipe = recipe['recipe']
        
        formatted_recipes.append({
                'url': recipe['url'],
                'title': recipe['label'],
                'img': recipe['image'],
                'src': recipe['source'],
                
            })
    
    
    return jsonify(formatted_recipes)
    



"""
******************************************************************************
Endpoint: /api/v1/notifications

Description: Endpoint that will trigger sending the notification to the user

Return: Success!
******************************************************************************
"""
PHRASE = "Be Aware! You have {} food item{} expiring soon!!! Click here to see some ways to use them!"
def send_notifications():
    results = get_expiring_items()
    
    qty = 0

    for result in results:
        expiry_date = datetime.strptime(result['expiryDate'], '%Y-%m-%d').date()
        today = date.today()
        daysLeft = (expiry_date - today).days

        if (daysLeft <= 3):
            qty += 1
            
    if (qty < 1):
        return None
    
    return PHRASE.format(qty, ('s', '')[qty == 1])

    
    
@app.route('/api/v1/test', methods=['GET'])
def test():
    print("FFFF")
    return "Working"



api.add_resource(Item, "/api/v1/modify/items/<string:fridge_id>")
api.add_resource(Receipt, "/api/v1/receipt")

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=3000, debug=True)