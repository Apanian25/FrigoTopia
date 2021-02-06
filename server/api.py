from flask import Flask, request, jsonify
from flask_restful import Api, Resource, reqparse, abort, fields, marshal_with
from db.firebase import getFridge, addItem, removeItem
from YoloDetection import YoloDetection
from FoodInformation import get_food_infomation


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
fridge_delete_args.add_argument("name", type=str, help="Name of the item is required", required=True)


resource_fields = {
    "name": fields.String,
    "expiryDate": fields.String,
    "qty": fields.String,
    "weight": fields.Integer,
    "volume": fields.Integer,
    "price": fields.Integer
}


class Item(Resource):
    def get(self, user_id):
        result = getFridge(user_id)
        if not result:
            abort(404,  message="Could not find user")
        return result

    @marshal_with(resource_fields)
    def put(self, user_id):
        args = fridge_put_args.parse_args()
        result = addItem(user_id, args)
        if not result:
            abort(500, message="Something went wrong when adding an item...")

        return result, 201

    @marshal_with(resource_fields)
    def delete(self, user_id):
        args = fridge_delete_args.parse_args()
        removeItem(user_id, args['name'])
        return {'message':'delete successfully'}, 204 #deleted successfully


class Receipt(Resource):
    def post(self):
        receipt = request.files['image']
        if receipt:
            print('image received')
        else:
            print('image not received')



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


# Temp import
import cv2 as cv

@app.route('/api/v1/image_upload', methods=['GET'])
def items_from_image():
    if 'imgType' not in request.args:
        return "Error"
        
    img = cv.imread("./YOLO/Fruits.jpg")
    foods = image_detector.getObjects(img)
    
    parsed_food = {}
    
    for food in foods:
        label = food['label']
        confidence = food['confidence']
        # x, y, w, h = food['rectangle']
        
        if (label not in food_items):
            continue
        
        if (label in parsed_food):
            total_confidence = parsed_food[label]['confidence']
            qty = parsed_food[label]['qty']
            
            parsed_food[label]['confidence'] = ((total_confidence * qty) + confidence)/(qty + 1)
            parsed_food[label]['qty'] += 1
        else:
            lifetime, tip = get_food_infomation(label)
            
            parsed_food[label] = {
                                    'name': label,
                                    'qty': 1,
                                    'confidence': confidence,
                                    'expiryDate': lifetime,
                                    'tip': tip
                                 }
    
    return jsonify(list(parsed_food.values()))






api.add_resource(Item, "/items/<string:user_id>")
api.add_resource(Receipt, "/receipt")

if __name__ == "__main__":
    app.run(debug=True)