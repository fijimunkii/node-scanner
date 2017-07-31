FROM node:7.10.1
MAINTAINER Harrison Powers, harrisonpowers@gmail.com

RUN npm install nsp retire plato notes -g

ADD https://github.com/Yelp/dumb-init/releases/download/v1.1.3/dumb-init_1.1.3_amd64 /usr/local/bin/dumb-init
RUN chmod +x /usr/local/bin/dumb-init

RUN mkdir -p /usr/src/app/logs

WORKDIR /usr/src/app
ADD scanner.sh .

ENTRYPOINT ["dumb-init"]

CMD bash /usr/src/app/scanner.sh
