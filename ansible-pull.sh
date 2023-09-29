#!/bin/sh
killall ansible-pull
ansible-pull -o -U https://github.com/LegitCamper/homelab-proxy.git &
