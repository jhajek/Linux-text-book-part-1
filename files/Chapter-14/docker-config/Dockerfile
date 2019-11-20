# TZ and DEBIAN_FRONTEND ENV vars set due to Ubuntu needing this
# https://serverfault.com/questions/949991/how-to-install-tzdata-on-a-ubuntu-docker-image
FROM ubuntu:latest
LABEL Jeremy Hajek <hajek@iit.edu>
ENV TZ=America/Chicago
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y apache2 php
VOLUME ../code/helloworld:/var/www/html
EXPOSE 80