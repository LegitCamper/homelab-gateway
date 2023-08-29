apt-get update
apt-get upgrade -y 
curl -fsSL https://tailscale.com/install.sh | sh
tailscale login
systemctl enable tailscale
tailscale up

iptables -t nat -A PREROUTING -p tcp --dport 1:65535 -j DNAT --to-destination homelab
iptables -t nat -A PREROUTING -p udp --dport 1:65535 -j DNAT --to-destination homelab
iptables -t nat -A POSTROUTING -p tcp --dport 1:65535 -j SNAT --to-source $(hostname -I) -d $(tailscale ip -4 homelab)
iptables -t nat -A POSTROUTING -p udp --dport 1:65535 -j SNAT --to-source $(hostname -I) -d $(tailscale ip -4 homelab)
