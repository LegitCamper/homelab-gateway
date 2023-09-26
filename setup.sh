apt-get update
apt-get upgrade -y 
apt-get install -y iptables-persistent
curl -fsSL https://tailscale.com/install.sh | sh
tailscale login
tailscale up

MYIP=$(ip addr show eth0 | grep "inet " | cut -d '/' -f1 | cut -d ' ' -f6 | head -n 1)
HLIP=$(tailscale ip -4 homelab):80
MYTSIP=$(tailscale ip -4)
EXT=eth0
INT=tailscale0
PORTS=1:65535

echo 1 >/proc/sys/net/ipv4/ip_forward
echo "net.ipv4.ip_forward = 1" > /etc/sysctl.conf

# forward traffic to homelab
iptables -t nat -A PREROUTING -i EXT -p tcp --dport $PORTS -j DNAT --to-destination $HLIP
iptables -t nat -A POSTROUTING -o INT -p tcp --sport $PORTS -j SNAT --to-source $MYTSIP:$PORTS
iptables -t nat -A PREROUTING -i EXT -p udp --dport $PORTS -j DNAT --to-destination $HLIP
iptables -t nat -A POSTROUTING -o INT -p udp --sport $PORTS -j SNAT --to-source $MYTSIP:$PORTS

# make rules persistent
sudo iptables-save > /etc/iptables/rules.v4
