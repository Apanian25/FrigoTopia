# -*- coding: utf-8 -*-
"""
Created on Sat Feb  6 00:44:05 2021

@author: jonat
"""
from datetime import date
import datetime

food_information = {
    'banana': {
        'ripe': {
            'tip': "Place in the fridge to give a longer lifespan!",
            'lifetime': 7
        },
        'green': {
            'tip': "Don't put in the fridge or else it will not ripe!",
            'lifetime': 10
        },
        'overripe': {
            'tip': "Consider freezing it if you can't use it in the next few days!",
            'lifetime': 2
        },
    },
    'apple': {
        'lifetime': 28
    },
    'sandwich': {
        'lifetime': 2
    },
    'orange': {
        'lifetime': 30
    },
    'broccoli': {
        'lifetime': 5
    },
    'carrot': {
        'lifetime': 35
    },
    'hot dog': {
        'lifetime': 3
    },
    'pizza': {
        'lifetime': 4
    },
    'donut': {
        'lifetime': 5
    },
    'cake': {
        'lifetime': 3
    },
}


"""
******************************************************************************
Function: get_food_infomation

Description: Given a food name, the function will retrieve the expected lifetime
of the object and use it to return the predicted expiry date of the food. If
the food is a banana, the function will predict the ripeness and will return
a tip on what to do with the banana.

Return: (lifetime: String, tip: String | None)
******************************************************************************
"""
def get_food_infomation(food_name, ripeness):
    if food_name not in food_information:
        return (None, None)
    
    if food_name != 'banana':
        lifetime = food_information[food_name]['lifetime']
        tip = None
    else: 
        if (ripeness is None):
            ripeness = 'green'
            
        info = food_information[food_name][ripeness]
        lifetime = info['lifetime']
        tip = info['tip']
        
    # Change lifetime to be a datetime
    lifetime = (date.today() + datetime.timedelta(days=lifetime)).strftime('%Y-%m-%d')
    
    return (lifetime, tip)