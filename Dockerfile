FROM alpine:3.9
LABEL maintainer="Nomical <support@nomical.com>"

ARG KUBECTL_URL=https://storage.googleapis.com/kubernetes-release/release/v1.14.0/bin/linux/amd64/kubectl
ARG AWS_IAM_AUTHENTICATOR_URL=https://amazon-eks.s3-us-west-2.amazonaws.com/1.11.5/2018-12-06/bin/linux/amd64/aws-iam-authenticator

ADD ${KUBECTL_URL} /usr/local/bin/kubectl
ADD ${AWS_IAM_AUTHENTICATOR_URL} /usr/local/bin/aws-iam-authenticator

# Install aws-cli
RUN apk --no-cache update && \
    apk --no-cache add python py-pip py-setuptools ca-certificates curl groff less gettext git && \
    pip --no-cache-dir install awscli

RUN chmod +x /usr/local/bin/kubectl && \
    chmod +x /usr/local/bin/aws-iam-authenticator

RUN adduser -D -u 10000 kubernetes
USER kubernetes

WORKDIR /home/kubernetes
CMD ["kubectl", "version", "--client"]