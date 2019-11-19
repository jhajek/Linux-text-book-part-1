FROM ubuntu:latest
LABEL Jeremy Hajek <hajek@iit.edu>
VOLUME ./code/helloworld:/var/www/html
RUN apt-get update && apt-get install -y apache2 php
EXPOSE 80