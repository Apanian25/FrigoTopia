# -*- coding: utf-8 -*-
"""
Created on Fri Feb  5 23:04:55 2021

@author: jonat
"""
import numpy as np
import cv2 as cv


# Constants
FONT = cv.FONT_HERSHEY_PLAIN

class YoloDetection():
    
    def __init__(self):
        # Load YOLO 
        self.net = cv.dnn.readNet('./YOLO/yolov3.weights', './YOLO/yolov3.cfg')
        
        # Load the classifications from the coco file
        with open("./YOLO/coco.names", "r") as f:
            self.classes = [line.strip() for line in f.readlines()]
        
        # Define the input and output layers
        self.layer_names = self.net.getLayerNames()
        self.output_layers = [self.layer_names[i[0] - 1] for i in self.net.getUnconnectedOutLayers()]
        
        
    def getObjects(self, img):
        # Get the dimensions of the image
        height, width, channels = img.shape
        
        # Transform the image to a blob 
        blob = cv.dnn.blobFromImage(img, 0.00392, (416, 416), (0, 0, 0), True, crop=False)
        
        self.net.setInput(blob)
        outs = self.net.forward(self.output_layers)
            
        # Create the arrays of the found objects to go into
        rectangles = []
        confidences = []
        class_ids = []
        
        # Showing objects detected on the screen
        for out in outs:
            for detection in out: 
                (rectangle, confidence, class_id) = self.parseSingleObject(detection, width, height)
                
                if (rectangle is None):
                    continue 
                
                rectangles.append(rectangle)
                confidences.append(confidence)
                class_ids.append(class_id)
                
        # Remove the noise of the object detection
        indexes = cv.dnn.NMSBoxes(rectangles, confidences, 0.35, 0.4)
        
        # Valid information to return
        valid = []
        
        for i in indexes:
            i = i[0]
            
            # Extract information that should be shown
            x, y, w, h = rectangles[i]
            confidence = confidences[i]
            label = self.classes[class_ids[i]]
            
            valid.append({'label': label, 'confidence': confidence, 'rectangle': rectangles[i]})
            
            # cv.rectangle(img, (x,y), (x + w, y + h), (0,255,0), 2)
            # cv.putText(img, f"{label}-{confidence}", (x, y + 30), FONT, 2, (0,255,0), 2)
            
        return valid
        
    
    def parseSingleObject(self, detection, width, height):
        # Get the confidence
        scores = detection[5:]
        class_id = np.argmax(scores)
        confidence = scores[class_id]
        
        if confidence > 0.35:
            # Object detected get the coordinates
            center_x = int(detection[0] * width)
            center_y = int(detection[1] * height)
            w = int(detection[2] * width)
            h = int(detection[3] * height)
            
            # Get the rect coordinates of the objects
            x = int(center_x - w / 2)
            y = int(center_y - h / 2)
            
            # Append the found details into our arrays
            return ([x, y, w, h], float(confidence), class_id)
        
        return (None, None, None)
    
    
    
    
# # """TEST"""
# # Use OpenCV to grab the webcam video feed
# video_feed = cv.VideoCapture(0)

# # Declare our class function
# yd = YoloDetection()

# # Grab images from file
# #files = ["Fruits2.jpg", "pizza.jpg", "Fruits.jpg", "Pizzaaaa.jpg", "p3.jpg", "p4.jpg"]

# for num in range(1,6):
#     img = cv.imread(f"./YOLO/P{num}.jpg")
#     print(yd.getObjects(img))
    
#     cv.imshow(f"Image {num}", img)

# cv.waitKey(0)
