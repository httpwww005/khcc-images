from bottle import get, route, run, template

import logging
logger = logging.getLogger()

import os
import pymongo

MONGODB_URI=os.environ["MONGODB_URI"]
client = pymongo.MongoClient(MONGODB_URI)

collection_imgur = client["khcc"]["imgur"]
collection_gdimages = client["khcc"]["gdimages"]

@route('/')
@route('/<house_id:re:[\d-]+>')
def index(house_id=None):
    addresses = sorted(list(collection_imgur.distinct("address")))

    return template('index', addresses = addresses)


@route('/images/<house_id:re:[\d-]+>')
def images(house_id):
    images = list(collection_imgur.find({"address":house_id}))[0]["images"]

    gdimages = list(collection_gdimages.find({"address":house_id}))

    return template('images', images = images, gdimages=gdimages)


port = int(os.environ.get('PORT',5000))
run(host='0.0.0.0', port=port, debug=False, reloader=True)
