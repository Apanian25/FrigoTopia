from google.cloud import vision
import io
from dictionary import getBaseItem

# Instantiates a client
client = vision.ImageAnnotatorClient()

def getTextFromImage(image_uri_local):
    # Loads the image into memory
    with io.open(image_uri_local, 'rb') as image_file:
        content = image_file.read()

    image = vision.Image(content=content)
    response = client.text_detection(image=image)
    res = response.text_annotations[0].description.splitlines()
    return res
    

def getItems(image_url):
    lines = getTextFromImage(image_url)
    items = []
    for line in lines:
        item = getBaseItem(line.strip())
        if item:
            items.append(item)
    return items


def getItemsFromTxt(image_uri):
    # text = getTextFromImage(image_uri)
    items = []
    with open(image_uri) as fp:
        line = fp.readline()

        while line:
            item = getBaseItem(line.strip())
            if item:
                items.append(item)
            line = fp.readline()
    
    for item in items:
        print(item)

# getItems('./receipts/txt/good1.txt')
# print('----------------------------')
# getItems('./receipts/txt/good2.txt')
# getTextFromImage('./receipts/img/good2.png')
items = getItems('./receipts/img/good2.png')
for item in items:
    print(item)


