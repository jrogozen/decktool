FROM node:13.7.0-alpine3.11

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install

COPY . .

EXPOSE $PORT

CMD node index.js