# Raspberry Valley image for mkdocs, based on Alpine
# To learn more, visit our github repository: https://github.com/raspberryvalley/docker-mkdocs
# Image available on Docker Hub: https://cloud.docker.com/repository/docker/raspberryvalley/mkdocs/general

# Raspberry Valley is a makerspace in Sweden, Karlskrona. You can visit our sites and check what's developing: 
# * Knowledge base: https://raspberry-valley.azurewebsites.net
# * Github pages: https://github.com/raspberryvalley
# * Docker hub: hub.docker.com/r/raspberryvalley/
# * Follow on Twitter: https://twitter.com/RaspberryValley

FROM alpine:3.13

LABEL maintainer = "raspberryvalley@outlook.com"

VOLUME  /mysite
WORKDIR /mysite

# To avoid Python printing issues (See: https://github.com/Docker-Hub-frolvlad/docker-alpine-python3/pull/13)
ENV PYTHONUNBUFFERED=1

RUN apk add --no-cache python3 && \
    if [ ! -e /usr/bin/python ]; then ln -sf python3 /usr/bin/python ; fi && \
    python3 -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip3 install --no-cache --upgrade pip setuptools wheel && \
    if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi && \
    apk add --no-cache python3-dev && \
    apk add --no-cache libc-dev linux-headers zeromq-dev gcc g++

RUN pip install --no-cache-dir mkdocs pymdown-extensions mkdocs-material markdown-include cython nbconvert
RUN pip install --no-cache-dir mknotebooks

EXPOSE 8000

ENTRYPOINT ["mkdocs"]
