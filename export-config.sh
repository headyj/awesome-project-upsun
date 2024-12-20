#!/bin/bash

function frontend {
    echo $OCONFIG_FRONTEND > /app/dist/web/conf.d/oConfig.json
}

function backend {
    echo $OCONFIG_BACKEND > /app/dist/node/conf.d/oConfig.json
    jq --arg draw_password "$DRAW_PASSWORD" '.auth.autoPassword = $draw_password' /app/dist/node/conf.d/oConfig.json > /tmp/oConfig.json && mv /tmp/oConfig.json /app/dist/node/conf.d/oConfig.json
}

if declare -f "$1" > /dev/null; then
  "$1"
else
  echo "Error: Function '$1' not found."
  echo "Usage: $0 {frontend|backend}"
fi
