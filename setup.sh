apt-get update
apt-get upgrade -y 
apt-get install iptables-persistent
curl -fsSL https://tailscale.com/install.sh | sh
tailscale login
tailscale up

MYIP=$(ip addr show eth0 | grep "inet " | cut -d '/' -f1 | cut -d ' ' -f6 | head -n 1)
HLIP=$(tailscale ip -4 homelab)
MYTSIP=$(tailscale ip -4)
EXT=eth0
INT=tailscale0

echo 1 >/proc/sys/net/ipv4/ip_forward
echo "net.ipv4.ip_forward = 1" > /etc/sysctl.conf

iptables --append PREROUTING -i EXT --table nat --protocol tcp --dport 1:65535 -j DNAT --to-destination $HLIP
iptables --append POSTROUTING -o INT --table nat --protocol tcp --dport 1:65535 -j SNAT --to-source $MYTSIP
iptables --append PREROUTING -i EXT --table nat --protocol udp --dport 1:65535 -j DNAT --to-destination $HLIP
iptables --append POSTROUTING -o INT --table nat --protocol udp --dport 1:65535 -j SNAT --to-source $MYTSIP

sudo iptables-save > /etc/iptables/rules.v4
