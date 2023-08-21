apt-get update
apt-get upgrade -y 
apt-get install -y ansible python3 python3-venv docker.io
systemctl enable docker

wget https://raw.githubusercontent.com/LegitCamper/homelab-proxy/main/requirements.yml 
ansible-galaxy install -r requirements.yml
ansible-pull -U https://github.com/LegitCamper/homelab-proxy.git

tailscale login
systemctl enable tailscale
tailscale up
