FROM alpine:3.20.3

ENV BATS_VERSION=1.11.0
ENV HELM_VERSION=3.16.1
ENV KUBECTL_VERSION=1.31.1
ENV KUSTOMIZE_VERSION=5.4.3

RUN apk update && \
    # Install dependencies for awscli.
    apk --no-cache add \
    bash \
    ca-certificates \
    curl \
    gettext \
    git \
    gnupg \
    jq \
    less \
    libc6-compat \
    musl \
    openssh-client \
    python3 \
    py3-crcmod \
    py3-pip \
    # Install kustomize
    && curl -L --output /tmp/kustomize_v${KUSTOMIZE_VERSION}.tar.gz https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2Fv${KUSTOMIZE_VERSION}/kustomize_v${KUSTOMIZE_VERSION}_linux_amd64.tar.gz && \
    tar -xvzf /tmp/kustomize_v${KUSTOMIZE_VERSION}.tar.gz -C /usr/local/bin && \
    chmod +x /usr/local/bin/kustomize && \
    # Install kubectl
    curl -LO https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl && \
    mv kubectl /usr/local/bin && \
    chmod +x /usr/local/bin/kubectl && \
    # Install helm
    curl -L --output /tmp/helm-v${HELM_VERSION}-linux-amd64.tar.gz https://get.helm.sh/helm-v${HELM_VERSION}-linux-amd64.tar.gz && \
    tar -xvzf /tmp/helm-v${HELM_VERSION}-linux-amd64.tar.gz -C /usr/local/bin && \
    mv /usr/local/bin/linux-amd64/helm /usr/local/bin/helm && \
    chmod +x /usr/local/bin/helm && \
    # Install bats
    curl -L --output /tmp/bats.tgz https://github.com/bats-core/bats-core/archive/v${BATS_VERSION}.tar.gz && \
    tar -xvzf /tmp/bats.tgz -C /tmp && \
    rm /tmp/bats.tgz && \
    /tmp/bats-core-${BATS_VERSION}/install.sh /usr/local/

ENTRYPOINT []
