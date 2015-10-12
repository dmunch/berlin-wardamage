FROM node:4-slim

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY package.json /usr/src/app/
RUN npm install

COPY ./index.js /usr/src/app/index.js
COPY ./public/ /usr/src/app/public/
COPY ./public/ /usr/src/app/public/
COPY ./data/wardamage_01_WGS84.json /usr/src/app/data/wardamage_01_WGS84.json
COPY ./data/wardamage_02_WGS84.json /usr/src/app/data/wardamage_02_WGS84.json

EXPOSE 3000
CMD [ "npm", "start" ]
