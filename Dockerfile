FROM alpine
LABEL maintainer = "raspberryvalley@outlook.com"

VOLUME  /mysite
WORKDIR /mysite

RUN apk add --no-cache python py-pip py-setuptools && \
    pip install --no-cache-dir mkdocs \
                               pymdown-extensions mkdocs-material \
                               markdown-include pygments && \ 
    apk del py-pip

EXPOSE 8000

ENTRYPOINT ["mkdocs"]
