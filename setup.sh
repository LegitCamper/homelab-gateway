apt-get update
apt-get upgrade -y 
apt-get install -y golang make docker.io
curl -fsSL https://tailscale.com/install.sh | sh
tailscale login
tailscale up --advertise-exit-node --hostname=homelab-proxy
tailscale cert homelab-proxy.dunker-arctic.ts.net

mkdir /etc/traefik
wget https://raw.githubusercontent.com/LegitCamper/homelab-proxy/main/traefik/traefik.toml -O /etc/traefik/traefik.toml
wget https://raw.githubusercontent.com/LegitCamper/homelab-proxy/main/traefik/dynamic.toml -O /etc/traefik/dynamic.toml

wget https://github.com/traefik/traefik/releases/download/v2.9.6/traefik_v2.9.6_linux_amd64.tar.gz -O traefik.tar.gz
tar xzvf traefik.tar.gz
./traefik &

# this is for after release of treafik v3.0
# git clone https://github.com/traefik/traefik.git
# cd traefik
# git checkout v3.0
# git pull origin v3.0 
# git pull

# # Generate UI static files
# make clean-webui generate-webui
# # required to merge non-code components into the final binary,
# # such as the web dashboard/UI
# go generate
# # Standard go build
# go build ./cmd/traefik
# ~/go/src/github.com/traefik/traefik
