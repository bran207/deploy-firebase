FROM ubuntu:18.04
RUN curl -sL https://firebase.tools | bash
COPY entrypoint.sh /usr/local/bin
ENTRYPOINT ["entrypoint.sh"]
