### Installation

 - Install packages: `apt-get update && apt-get upgrade && apt-get install ansible python3 python3-venv docker.io && systemctl enable docker helix`
 - Install roles: `wget https://raw.githubusercontent.com/LegitCamper/homelab-proxy/main/requirements.yml && ansible-galaxy install -r requirements.yml`
<!---
 - Copy ansible password: `hx ~/.ansible-pass`
 - Get ACME and decrypt it: `wget -O ~/acme.json https://raw.githubusercontent.com/LegitCamper/homelab-proxy/main/traefik/acme.json && ansible-vault decrypt ~/acme.json`
-->
 - Run ansible playbook: `ansible-pull -U https://github.com/LegitCamper/homelab-proxy.git`
 - Secure server (Only run while ssh is runnin through tailscale!): `
   ufw allow in on tailscale0 &&
   ufw enable &&
   ufw default deny incoming &&
   ufw default allow outgoing &&
   ufw status &&
   ufw delete 22/tcp &&
   ufw reload &&
   service ssh restart &&
   `
