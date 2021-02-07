# -*- coding: utf-8 -*-
"""
Created on Sat Feb  6 12:44:24 2021

@author: jonat
"""
import numpy as np
from tensorflow import keras
import cv2 as cv

CLASSIFICATIONS = ['green', 'overripe', 'ripe']

class RipenessDetection():
    
    def __init__(self):
        self.model = keras.models.load_model('./YOLO/weights.14.h5')

    def get_ripeness(self, img):
        img = cv.cvtColor(img, cv.COLOR_BGR2RGB)
        img = cv.resize(img, dsize=(224, 224), interpolation=cv.INTER_CUBIC)
        img = img.astype(np.float32)
        img = img/255
        img = np.expand_dims(img, axis=0)
        result = self.model.predict_generator(img)
        index = np.argmax(result)
        
        return CLASSIFICATIONS[index]
    