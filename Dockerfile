FROM debian:buster-slim
RUN apt-get update \
  && apt-get install apt-utils -y \
  && apt-get install sudo -y \
  && apt-get install curl -y \
  && curl -sL https://firebase.tools | bash \
  && apt-get install -y python3-pip python3-dev \
  && cd /usr/local/bin \
  && ln -s /usr/bin/python3 python \
  && pip3 install --upgrade pip \
  && pip3 install requests \
  && apt-get install nodejs -y \
  && apt-get install npm -y \
  && npm install javascript-obfuscator \
  && npm link javascript-obfuscator

COPY entrypoint.sh /usr/local/bin
COPY minify.py /usr/local/bin
ENTRYPOINT ["entrypoint.sh"]
