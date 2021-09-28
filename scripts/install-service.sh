#!/bin/bash

SYSTEMD_FILE="/etc/systemd/system/eleetcoach.service" 
TMP_FILE="./.tmp.eleetcoach.service"

if [[ ! -f "$SYSTEMD_FILE" ]]
then
  echo "generating $SYSTEMD_FILE file for systemd"
  RVM=$(which rvm) APPDIR=$(pwd) envsubst < "./config/eleetcoach.service.template" > "$TMP_FILE"
  sudo mv "$TMP_FILE" "$SYSTEMD_FILE"
  echo "generated $SYSTEMD_FILE file"
else
  echo "found $SYSTEMD_FILE file"
fi

sudo systemctl start eleetcoach
sudo systemctl enable eleetcoach
sleep 1
sudo systemctl status eleetcoach
