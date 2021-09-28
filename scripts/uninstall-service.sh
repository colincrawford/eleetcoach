#!/bin/bash

sudo systemctl stop eleetcoach
sudo systemctl disable eleetcoach
sudo rm /etc/systemd/system/eleetcoach.service
