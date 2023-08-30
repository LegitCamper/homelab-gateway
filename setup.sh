apt-get update
apt-get upgrade -y 
apt-get install -y iptables-persistent
curl -fsSL https://tailscale.com/install.sh | sh
tailscale login
tailscale up

MYIP=$(ip addr show eth0 | grep "inet " | cut -d '/' -f1 | cut -d ' ' -f6 | head -n 1)
HLIP=$(tailscale ip -4 homelab):8080
MYTSIP=$(tailscale ip -4)
EXT=eth0
INT=tailscale0
PORTS=1:65535

echo 1 >/proc/sys/net/ipv4/ip_forward
echo "net.ipv4.ip_forward = 1" > /etc/sysctl.conf

# forward traffic to homelab
iptables -A PREROUTING -i EXT --table nat -p tcp --dport $PORTS -j DNAT --to-destination $HLIP
iptables -A POSTROUTING -o INT --table nat -p tcp --dport $PORTS -j SNAT --to-source $MYTSIP
iptables -A PREROUTING -i EXT --table nat -p udp --dport $PORTS -j DNAT --to-destination $HLIP
iptables -A POSTROUTING -o INT --table nat -p udp --dport $PORTS -j SNAT --to-source $MYTSIP

# make rules persistent
sudo iptables-save > /etc/iptables/rules.v4
