from __future__ import print_function
import json
import sys
from bottle import get, route, run, template
import re
import datetime
from datetime import date
from bottle import response

import logging
logger = logging.getLogger()

import os
import pymongo
import gridfs
import pytz
from bson.codec_options import CodecOptions

TZ=pytz.timezone("Asia/Taipei")

MONGODB_URI=os.environ["MONGODB_URI"]
client = pymongo.MongoClient(MONGODB_URI)

collection_imgur = client["khcc"]["imgur"]
collection_gdimages = client["khcc"]["gdimages"]


@get('/')
def index():
    addresses = sorted(list(collection_imgur.distinct("address")))

    return template('index', addresses = addresses)


@route('/images/<house_id:re:[\d-]+>')
def images(house_id):
    images = list(collection_imgur.find({"address":house_id}))[0]["images"]

    gdimages = list(collection_gdimages.find({"address":house_id}))

    return template('images', images = images, gdimages=gdimages)


port = int(os.environ.get('PORT',5000))
run(host='0.0.0.0', port=port, debug=False, reloader=True)
