apt-get update
apt-get upgrade -y 
curl -fsSL https://tailscale.com/install.sh | sh
tailscale login
systemctl enable tailscale
tailscale up

MYIP=$(ip addr show eth0 | grep "inet " | cut -d '/' -f1 | cut -d ' ' -f6 | head -n 1)

echo 1 >/proc/sys/net/ipv4/ip_forward
echo "net.ipv4.ip_forward = 1" > /etc/sysctl.conf

iptables -t nat -A PREROUTING -p tcp --dport 1:65535 -j DNAT --to-destination $(tailscale ip -4 homelab)
iptables -t nat -A PREROUTING -p udp --dport 1:65535 -j DNAT --to-destination $(tailscale ip -4 homelab)
iptables -t nat -A POSTROUTING -p tcp --dport 1:65535 -j SNAT --to-source $MYIP -d $(tailscale ip -4 homelab)
iptables -t nat -A POSTROUTING -p udp --dport 1:65535 -j SNAT --to-source $MYIP -d $(tailscale ip -4 homelab)

#iptables -A PREROUTING -t nat -i eth0 -p tcp --dport 1:65535 -j DNAT --to $(tailscale ip -4 homelab)
#iptables -A FORWARD -p tcp -d $(tailscale ip -4 homelab) --dport 1:65535 -j ACCEPT
#iptables -A PREROUTING -t nat -i eth0 -p udp --dport 1:65535 -j DNAT --to $(tailscale ip -4 homelab)
#iptables -A FORWARD -p udp -d $(tailscale ip -4 homelab) --dport 1:65535 -j ACCEPT

iptables -A FORWARD -i eth0 -o tailscale0 -j ACCEPT
iptables -A FORWARD -i eth0 -o tailscale0 -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -t nat -A POSTROUTING -o wlan0 -j MASQUERADE
