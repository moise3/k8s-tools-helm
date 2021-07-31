FROM alpine:3.14.0

ARG HELM_VERSION=v3.6.3

LABEL Name=helm Version=${HELM_VERSION}

ADD https://get.helm.sh/helm-${HELM_VERSION}-linux-amd64.tar.gz /config/helm.tar.gz

ENV HOME=/config

RUN set -x && \
    apk add --no-cache curl && \
    tar -zxvf /config/helm.tar.gz --directory /config && \
    mv /config/linux-amd64/helm /usr/local/bin/helm && \
    rm -rf helm.tar.gz linux-amd64 && \
    adduser helm -Du 2342 -h /config && \
    helm version --client --short

USER helm

ENTRYPOINT ["/usr/local/bin/helm"]
