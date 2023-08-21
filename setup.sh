apt-get update && apt-get upgrade && apt-get install -y ansible python3 python3-venv docker.io helix && systemctl enable docker

wget https://raw.githubusercontent.com/LegitCamper/homelab-proxy/main/requirements.yml && ansible-galaxy install -r requirements.yml
ansible-pull -U https://github.com/LegitCamper/homelab-proxy.git

tailscale login && tailscale up && systemctl enable tailscale
