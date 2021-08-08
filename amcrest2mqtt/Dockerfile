FROM dchesterton/amcrest2mqtt:1.0.7

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
