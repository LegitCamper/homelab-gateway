apt-get update
apt-get upgrade -y 
curl -fsSL https://tailscale.com/install.sh | sh
tailscale login
systemctl enable tailscale
tailscale up

MYIP=$(ip addr show eth0 | grep "inet " | cut -d '/' -f1 | cut -d ' ' -f6 | tail -n 1)

iptables -t nat -A PREROUTING -p tcp --dport 1:65535 -j DNAT --to-destination $(tailscale ip -4 homelab):8080
iptables -t nat -A PREROUTING -p udp --dport 1:65535 -j DNAT --to-destination $(tailscale ip -4 homelab):8080
iptables -t nat -A POSTROUTING -p tcp --dport 1:65535 -j SNAT --to-source $MYIP -d $(tailscale ip -4 homelab):8080
iptables -t nat -A POSTROUTING -p udp --dport 1:65535 -j SNAT --to-source $MYIP -d $(tailscale ip -4 homelab):8080
