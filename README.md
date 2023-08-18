### Installation

 - Install packages: `apt-get update && apt-get upgrade && apt-get install ansible python3 python3-venv docker && systemctl enable docker`
 - Install roles: `wget https://raw.githubusercontent.com/LegitCamper/homelab-proxy/main/requirements.yml && ansible-galaxy install -r requirements.yml`
 - Command: `ansible-pull -U https://github.com/LegitCamper/homelab-proxy.git`
