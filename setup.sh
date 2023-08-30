apt-get update
apt-get upgrade -y 
apt-get install iptables-persistent
curl -fsSL https://tailscale.com/install.sh | sh
tailscale login
tailscale up

MYIP=$(ip addr show eth0 | grep "inet " | cut -d '/' -f1 | cut -d ' ' -f6 | head -n 1)
HLIP=$(tailscale ip -4 homelab):8080
MYTSIP=$(tailscale ip -4)
EXT=eth0
INT=tailscale0

echo 1 >/proc/sys/net/ipv4/ip_forward
echo "net.ipv4.ip_forward = 1" > /etc/sysctl.conf

# basic firewall to force auth for domain
iptables -A INPUT -i $EXT -p tcp --dport 22 -j REJECT --reject-with tcp-reset

# forward traffic to homelab
iptables -A PREROUTING -i EXT --table nat -p tcp --dport all -j DNAT --to-destination $HLIP
iptables -A POSTROUTING -o INT --table nat -p tcp --dport all -j SNAT --to-source $MYTSIP
iptables -A PREROUTING -i EXT --table nat -p udp --dport all -j DNAT --to-destination $HLIP
iptables -A POSTROUTING -o INT --table nat -p udp --dport all -j SNAT --to-source $MYTSIP

# make rules persistent
sudo iptables-save > /etc/iptables/rules.v4
