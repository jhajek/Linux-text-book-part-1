FROM node:12.2.0-stretch
LABEL Jarron Bailey <baileyjarron@gmail.com>
WORKDIR /app
COPY ./src/package* /app/
RUN npm install
COPY ./src/ /app