FROM ubuntu:18.04
RUN apt-get update \
  && apt-get install sudo -y \
  && apt-get install curl -y \
  && curl -sL https://firebase.tools | bash \
  && apt-get install -y python3-pip python3-dev \
  && cd /usr/local/bin \
  && ln -s /usr/bin/python3 python \
  && pip3 install --upgrade pip

COPY entrypoint.sh /usr/local/bin
COPY minify.py /usr/local/bin
ENTRYPOINT ["entrypoint.sh"]
