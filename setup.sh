apt-get update
apt-get upgrade -y 
apt-get install -y iptables-persistent
curl -fsSL https://tailscale.com/install.sh | sh
tailscale login
tailscale up --advertise-exit-node --hostname=homelab-proxy

wget https://raw.githubusercontent.com/LegitCamper/homelab-proxy/main/traefik/traefik.toml
wget https://raw.githubusercontent.com/LegitCamper/homelab-proxy/main/traefik/dynamic.toml

docker run -d --net=host -v $PWD/traefik.toml:/etc/traefik/traefik.toml -v $PWD/dynamic.toml:/etc/traefik/dynamic.toml traefik
