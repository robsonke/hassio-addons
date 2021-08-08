#!/usr/bin/env bashio
set +u

LOGGING=$(bashio::info 'hassio.info.logging' '.logging')

# Read in the file of environment settings
bashio::log.info 'Read all configuration settigns'

# Amcrest Device settings
export AMCREST_HOST=$(bashio::config 'amcrest_host')
export AMCREST_PORT=$(bashio::config 'amcrest_port')
export AMCREST_USERNAME=$(bashio::config 'amcrest_username')
export AMCREST_PASSWORD=$(bashio::config 'amcrest_password')

# MQTT settings
if bashio::config.has_value 'mqtt_username'; then
  export MQTT_USERNAME=$(bashio::config 'mqtt_username')
else
  export MQTT_USERNAME=$(bashio::services mqtt "username")
fi

# fallback to the settings of hassio itself if they're not set
if bashio::config.has_value 'mqtt_password'; then
  export MQTT_PASSWORD=$(bashio::config 'mqtt_password')
else
  export MQTT_PASSWORD=$(bashio::services mqtt "password")
fi

if bashio::config.has_value 'mqtt_host'; then
  export MQTT_HOST=$(bashio::config 'mqtt_host')
else
  export MQTT_HOST=$(bashio::services mqtt "host")
fi

if bashio::config.has_value 'mqtt_qos'; then
  export MQTT_QOS=$(bashio::config 'mqtt_qos')
fi

if bashio::config.has_value 'mqtt_port'; then
  export MQTT_PORT=$(bashio::config 'mqtt_port')
fi

# MQTT TLS settings, only required when enabled
if bashio::config.has_value 'mqtt_tls_enabled'; then
  export MQTT_TLS_ENABLED=$(bashio::config 'mqtt_tls_enabled')

  if [ "$MQTT_TLS_ENABLED" = true ] ; then
    export MQTT_TLS_CA_CERT=$(bashio::config 'mqtt_tls_ca_cert')
    export MQTT_TLS_CERT=$(bashio::config 'mqtt_tls_cert')
    export MQTT_TLS_KEY=$(bashio::config 'mqtt_tls_key')
  fi
fi

# Home Assistant settings
export HOME_ASSISTANT=true
if bashio::config.has_value 'home_assistant_prefix'; then
  export HOME_ASSISTANT_PREFIX=$(bashio::config 'home_assistant_prefix')
fi

if bashio::config.has_value 'storage_poll_interval'; then
  export STORAGE_POLL_INTERVAL=$(bashio::config 'storage_poll_interval')
fi

# And run the CMD command
bashio::log.info 'Start the amcrest2mqtt.py'
exec "$@"
