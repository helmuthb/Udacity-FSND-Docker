FROM ubuntu:16.04

EXPOSE 8000/tcp
EXPOSE 8080/tcp
EXPOSE 5000/tcp

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -qqy update && \
    apt-get -y -o Dpkg::Options::="--force-confdef" \
               -o Dpkg::Options::="--force-confold" upgrade && \
    apt-get -qqy install make zip unzip postgresql wget && \
    apt-get -qqy install python3 python3-pip && \
    apt-get -qqy install python python-pip

RUN pip3 install flask packaging oauth2client redis passlib && \
    pip3 install flask-httpauth sqlalchemy flask-sqlalchemy && \
    pip3 install psycopg2-binary bleach requests

RUN pip2 install flask packaging oauth2client redis passlib && \
    pip2 install flask-httpauth sqlalchemy flask-sqlalchemy && \
    pip2 install psycopg2-binary bleach requests

RUN wget http://download.redis.io/redis-stable.tar.gz && \
    tar xvzf redis-stable.tar.gz && \
    cd redis-stable && \
    make && \
    make install

RUN useradd -m -s /bin/bash -b / vagrant && \
    service postgresql start && \
    su postgres -c 'createuser -dRS vagrant' &&\
    su vagrant -c 'createdb && createdb news && createdb forum'

USER vagrant

COPY . /vagrant

CMD /bin/bash