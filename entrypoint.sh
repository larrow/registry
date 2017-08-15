#!/bin/sh

set -e

CONFIG_FILE="/etc/docker/registry/config.yml"

cat /config.yml.template \
  | sed "s/Bearer/Bearer ${SERVICE_TOKEN}/" \
  | sed "s/host_port/${NTF_HOST_PORT}/" > $CONFIG_FILE

case "$1" in
    *.yaml|*.yml) set -- registry serve "$@" ;;
    serve|garbage-collect|help|-*) set -- registry "$@" ;;
esac

exec "$@"
