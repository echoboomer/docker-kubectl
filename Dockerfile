FROM alpine:3.12.0

ENV BATS_VERSION=1.1.0
ENV CLOUD_SDK_VERSION=310.0.0
ENV HELM_VERSION=3.5.0
ENV KUBECTL_VERSION=1.17.12
ENV KUSTOMIZE_VERSION=3.9.2
ENV PATH /google-cloud-sdk/bin:$PATH

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
    # Install gcp dependencies
    && curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz && \
    tar xzf google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz && \
    rm google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz && \
    gcloud config set core/disable_usage_reporting true && \
    gcloud config set component_manager/disable_update_check true && \
    gcloud --version && \
    # Install awscli
    pip3 install --no-cache-dir setuptools awscli yq && \
    mkdir /root/.aws && \
    aws --version && \
    # Install kustomize
    curl -L --output /tmp/kustomize_v${KUSTOMIZE_VERSION}.tar.gz https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2Fv${KUSTOMIZE_VERSION}/kustomize_v${KUSTOMIZE_VERSION}_linux_amd64.tar.gz && \
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
    /tmp/bats-core-${BATS_VERSION}/install.sh /usr/local/ && \
    # install enhanced version of envsubst so we can have more complex variable substitution
    # https://github.com/a8m/envsubst
    curl -L https://github.com/a8m/envsubst/releases/download/v1.2.0/envsubst-`uname -s`-`uname -m` -o envsubst && \
    chmod +x envsubst && \
    mv envsubst /usr/local/bin

COPY ./scripts /scripts

ENTRYPOINT []
