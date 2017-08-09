#!/bin/sh

set -e

CERT_FILE="/etc/docker/registry/cert.pem"
CONFIG_FILE="/etc/docker/registry/config.yml"
if [ ! -f "$CERT_FILE" ]
then
  echo "Cannot find $CERT_FILE" >&2
  exit 1
fi

sed "s/Bearer/Bearer ${SERVICE_TOKEN}/" /config.yml.template > $CONFIG_FILE

case "$1" in
    *.yaml|*.yml) set -- registry serve "$@" ;;
    serve|garbage-collect|help|-*) set -- registry "$@" ;;
esac

exec "$@"