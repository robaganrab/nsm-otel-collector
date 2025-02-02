ARG COC_VERSION=new-3d29ec2ebbf58020209f17830809e1ba
ARG OTEL_VERSION=0.84.0

FROM golang:1.20-alpine3.17 as ocb
RUN set -ex && \
    apk --update add git wget
ENV GO111MODULE=on
RUN go install go.opentelemetry.io/collector/cmd/builder@latest
WORKDIR /gen
ARG COC_VERSION
COPY ./otel-collector-builder_${COC_VERSION}.yaml /gen/otel-collector-builder.yaml
ARG OTEL_VERSION
RUN sed -i -e 's/OTEL_VERSION/'${OTEL_VERSION}'/' otel-collector-builder.yaml
CMD builder --skip-compilation --config=otel-collector-builder.yaml
