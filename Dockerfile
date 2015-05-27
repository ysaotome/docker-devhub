FROM ysaotome/ubuntu:14.04

MAINTAINER Yuichi Saotome <y@sotm.jp>

# env
ENV DEVHUB_TITLE docker-devhub
ENV DEVHUB_DB devhub_db
ENV DEVHUB_PORT 3000

# Install node
ENV DEBIAN_FRONTEND noninteractive
RUN wget -qO- https://deb.nodesource.com/setup | bash -
RUN apt-get update && apt-get install -y nodejs mongodb-clients && apt-get clean

# Install DevHub
RUN git clone https://github.com/volpe28v/DevHub.git /DevHub
WORKDIR /DevHub
RUN npm install

## debhub backup
RUN mkdir /DevHub/backupdb
RUN echo "*/5 * * * * mongodump --host \${MONGO_PORT_27017_TCP_ADDR}:\${MONGO_PORT_27017_TCP_PORT} --db ${DEVHUB_DB} --out /DevHub/backupdb > /var/log/cron.log 2>&1" | crontab -

VOLUME /DevHub

EXPOSE ${DEVHUB_PORT}
CMD export MONGOLAB_URI="mongodb://${MONGO_PORT_27017_TCP_ADDR}:${MONGO_PORT_27017_TCP_PORT}/${DEVHUB_DB}" && /usr/bin/node app.js -p ${DEVHUB_PORT} -d ${DEVHUB_DB} -t ${DEVHUB_TITLE}

