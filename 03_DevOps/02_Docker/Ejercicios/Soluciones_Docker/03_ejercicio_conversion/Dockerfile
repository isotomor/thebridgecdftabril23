FROM mongo:latest

# Ahora instalamos python3 y python3-pip
RUN apt-get update && apt-get install -y python3 python3-pip && apt-get -y install python3.7-dev

# instalamos pymongo, la librería de mongo para python con pip
RUN pip install pymongo

# exponemos el puerto oficial de mongo
EXPOSE 27017
