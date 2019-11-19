FROM ubuntu:latest
LABEL Jeremy Hajek <hajek@iit.edu>
VOLUME ./code/helloworld:/var/www/html
RUN DEBIAN_FRONTEND=noninteractive apt install -y tzdata
RUN apt-get update && apt-get install -y apache2 php
EXPOSE 80