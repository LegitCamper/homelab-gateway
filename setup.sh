apt-get update
apt-get upgrade -y 
apt-get install -y docker.io
curl -fsSL https://tailscale.com/install.sh | sh
tailscale login
tailscale up --advertise-exit-node --hostname=homelab-proxy

mkdir /etc/traefik
wget https://raw.githubusercontent.com/LegitCamper/homelab-proxy/main/traefik/traefik.toml -O /etc/traefik/traefik.toml
wget https://raw.githubusercontent.com/LegitCamper/homelab-proxy/main/traefik/dynamic.toml -O /etc/traefik/dynamic.toml

wget https://github.com/traefik/traefik/releases/download/v2.9.6/traefik_v2.9.6_linux_amd64.tar.gz
tar xzvf traefik_v2.9.6_linux_amd64.tar.gz
./traefik &
