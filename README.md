### Installation

 - Install packages: `apt-get update && apt-get upgrade && apt-get install -y ansible python3 python3-venv docker.io && systemctl enable docker helix`
 - Install roles: `wget https://raw.githubusercontent.com/LegitCamper/homelab-proxy/main/requirements.yml && ansible-galaxy install -r requirements.yml`
 - Run ansible playbook: `ansible-pull -U https://github.com/LegitCamper/homelab-proxy.git`
 - Sign into tailscale `tailscale login && tailscale up && systemctl enable tailscale`
 - Secure server (Only run while ssh is running through tailscale!): `
   ufw allow in on tailscale0 &&
   ufw enable &&
   ufw default deny incoming &&
   ufw allow 80 && 
   ufw allow 443 &&
   ufw allow 8080 &&
   ufw default allow outgoing &&
   ufw status &&
   ufw delete 22/tcp &&
   ufw reload &&
   service ssh restart
   `
