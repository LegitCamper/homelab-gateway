apt-get update
apt-get upgrade -y 
apt-get install -y iptables-persistent
curl -fsSL https://tailscale.com/install.sh | sh
tailscale login
tailscale up --advertise-exit-node

MYIP=$(ip addr show eth0 | grep "inet " | cut -d '/' -f1 | cut -d ' ' -f6 | head -n 1)
HLIP=$(tailscale ip -4 homelab)
MYTSIP=$(tailscale ip -4)
EXT=eth0
INT=tailscale0
PORTSC=1:65535
PORTSH=1-65535

echo 1 >/proc/sys/net/ipv4/ip_forward
echo "net.ipv4.ip_forward = 1" > /etc/sysctl.conf

# forward traffic to homelab
iptables -t nat -m multiport -A PREROUTING -i EXT -p tcp --dport $PORTSC -j DNAT --to-destination $HLIP
iptables -t nat -m multiport -A POSTROUTING -o INT -p tcp --sport $PORTSC -j SNAT --to-source $MYTSIP:$PORTSH
iptables -t nat -m multiport -A PREROUTING -i EXT -p udp --dport $PORTSC -j DNAT --to-destination $HLIP
iptables -t nat -m multiport -A POSTROUTING -o INT -p udp --sport $PORTSC -j SNAT --to-source $MYTSIP:$PORTSH

# make rules persistent
sudo iptables-save > /etc/iptables/rules.v4
