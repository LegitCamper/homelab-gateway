### Installation

 - Install packages: `apt-get update && apt-get upgrade && apt-get install ansible python3 python3-venv docker.io && systemctl enable docker`
 - Install roles: `wget https://raw.githubusercontent.com/LegitCamper/homelab-proxy/main/requirements.yml && ansible-galaxy install -r requirements.yml`
 - Command: `ansible-pull -U https://github.com/LegitCamper/homelab-proxy.git`
 - Secure Server (Only run while ssh is runnin through tailscale!): `
   ufw allow in on tailscale0 &&
   ufw enable &&
   ufw default deny incoming &&
   ufw default allow outgoing &&
   ufw status &&
   ufw delete 22/tcp &&
   ufw reload &&
   service ssh restart &&
   `
