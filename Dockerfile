## Build plugin
ARG KONG_VERSION
FROM kong:${KONG_VERSION} as builder

# Root needed to install dependencies
USER root

RUN apk --no-cache add zip
WORKDIR /tmp

COPY ./*.rockspec /tmp
COPY ./LICENSE.txt /tmp/LICENSE
COPY ./kong /tmp/kong

ARG PLUGIN_VERSION

RUN luarocks make && luarocks pack kong-plugin-upstream-auth-basic ${PLUGIN_VERSION}

## Create Image
FROM kong:${KONG_VERSION}

ENV KONG_PLUGINS="bundled,upstream-auth-basic"

COPY --from=builder /tmp/*.rock /tmp/

# Root needed for installing plugin
USER root

ARG PLUGIN_VERSION
RUN luarocks install /tmp/kong-plugin-upstream-auth-basic-${PLUGIN_VERSION}.all.rock