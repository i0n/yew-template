FROM i0nw/rust-wasm-builder:1.66 as builder

ARG DOCKER_ARG_VERSION
ARG DOCKER_ARG_REV
ARG DOCKER_ARG_BRANCH
ARG DOCKER_ARG_BUILD_USER

ENV VERSION=$DOCKER_ARG_VERSION
ENV REV=$DOCKER_ARG_REV
ENV BRANCH=$DOCKER_ARG_BRANCH
ENV BUILD_USER=$DOCKER_ARG_BUILD_USER

COPY . /opt/data
WORKDIR /opt/data

RUN RUST_VERSION=$(rustc --version) trunk build --release

#########################################################################################

FROM i0nw/http-file-server:latest

ENV APP_NAME=yew-template
ENV APP_ENVIRONMENT=production
ENV LOG_LEVEL=debug

COPY --from=builder /opt/data/dist /usr/bin/public 
