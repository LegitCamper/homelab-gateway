#!/bin/sh
killall ansible-pull
ansible-pull -U https://github.com/LegitCamper/homelab-proxy.git &
