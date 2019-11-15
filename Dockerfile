# Raspberry Valley image for mkdocs, based on Alpine
# To learn more, visit our github repository: https://github.com/raspberryvalley/docker-mkdocs
# Image available on Docker Hub: https://cloud.docker.com/repository/docker/raspberryvalley/mkdocs/general

# Raspberry Valley is a makerspace in Sweden, Karlskrona. You can visit our sites and check what's developing: 
# * Knowledge base: https://raspberry-valley.azurewebsites.net
# * Github pages: https://github.com/raspberryvalley
# * Docker hub: hub.docker.com/r/raspberryvalley/
# * Follow on Twitter: https://twitter.com/RaspberryValley

FROM alpine:3.10

LABEL maintainer = "raspberryvalley@outlook.com"

VOLUME  /mysite
WORKDIR /mysite

RUN apk add --no-cache python && \
    python -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip install --upgrade pip setuptools && \
    rm -r /root/.cache

RUN pip install --no-cache-dir mkdocs pymdown-extensions mkdocs-material markdown-include pygments

EXPOSE 8000

ENTRYPOINT ["mkdocs"]