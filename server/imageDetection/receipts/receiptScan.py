from google.cloud import vision
from imageDetection.receipts.dictionary import getBaseItem

# Instantiates a client
client = vision.ImageAnnotatorClient()

def getTextFromImage(image_file):
    # Loads the image into memory
    content = image_file.read()

    image = vision.Image(content=content)
    response = client.text_detection(image=image)
    res = response.text_annotations[0].description.splitlines()
    return res
    

def getItems(image):
    lines = getTextFromImage(image)
    items = []
    for line in lines:
        if line[0].isdigit():
            line = line.split(' ', 1)[-1]
        item = getBaseItem(line.strip())
        if item:
            items.append({'name': item, 'qty': 1})
    return items


def getItemsFromTxt(image_uri):
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
# items = getItems('./receipts/img/good2.png')
# for item in items:
#     print(item)


