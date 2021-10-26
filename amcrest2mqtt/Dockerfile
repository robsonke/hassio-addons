# Build arugments
ARG BUILD_ARCH
ARG BUILD_DATE
ARG BUILD_REF
ARG BUILD_VERSION
FROM dchesterton/amcrest2mqtt:1.0.11

# Labels
LABEL \
    io.hass.name="Amcrest2mqtt" \
    io.hass.description="MQTT bridge between Amcrest and Home Assistant" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    org.label-schema.description="MQTT bridge between Amcrest and Home Assistant" \
    org.label-schema.build-date=${BUILD_DATE} \
    org.label-schema.name="Amcrest2mqtt" \
    org.label-schema.schema-version="0.1.0" \
    org.label-schema.vcs-ref=${BUILD_REF} \
    org.label-schema.vendor="Community Hass.io Add-ons"

RUN \
    set -x \
    && apk add --no-cache \
        bash \
        bind-tools \
        curl \
        jq \
        tzdata \
    \
    && mkdir -p /usr/src/bashio \
    && curl -L -f -s "https://github.com/hassio-addons/bashio/archive/v0.13.1.tar.gz" \
        | tar -xzf - --strip 1 -C /usr/src/bashio \
    && mv /usr/src/bashio/lib /usr/lib/bashio \
    && ln -s /usr/lib/bashio/bashio /usr/bin/bashio \
    && rm -rf /usr/src/*

COPY run.sh .
ENTRYPOINT ["./run.sh"]
CMD [ "python", "-u", "/app/amcrest2mqtt.py" ]
