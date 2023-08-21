apt-get update
apt-get upgrade 
apt-get install -y ansible ansible-galaxy python3 python3-venv docker.io helix 
systemctl enable docker

wget https://raw.githubusercontent.com/LegitCamper/homelab-proxy/main/requirements.yml 
ansible-galaxy install -r requirements.yml
ansible-pull -U https://github.com/LegitCamper/homelab-proxy.git

tailscale login
systemctl enable tailscale
tailscale up
