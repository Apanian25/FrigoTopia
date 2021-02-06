from flask import Flask
from flask_restful import Api, Resource, reqparse, abort, fields, marshal_with
from db.firebase import getFridge, addItem, removeItem

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


api.add_resource(Item, "/items/<string:user_id>")

if __name__ == "__main__":
    app.run(debug=True)