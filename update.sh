# allows kernel to receive and forward packets 
echo 1 > /proc/sys/net/ipv4/ip_forward

# clear all iptable rules
iptables -P INPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -P OUTPUT ACCEPT
iptables -t nat -F
iptables -t mangle -F
iptables -F
iptables -X

# installs and/or updates tailscale
curl -fsSL https://tailscale.com/install.sh | sh
systemctl enable tailscaled.service
# ensure api key exists
if [ ! -f /root/tailscaleapikey.txt ]; then
  echo "API KEY not found!"
  exit 0
fi
tailscale login --authkey=$(</root/tailscaleapikey.txt)
tailscale up --hostname=homelab-gateway --ssh

# get the ip of the homelab server
homelabip=$(tailscale ip homelab | head -n 1)
serverip=$(tailscale ip | head -n 1)

# pass any traffic that did not get filtered by the firewall to homelab via tailscale route
iptables -t nat -A PREROUTING -i eth0 -j DNAT --to-destination $homelabip

# Masks homelab and makes server act as gateway
iptables -t nat -A POSTROUTING -j MASQUERADE
iptables -t nat -A POSTROUTING -d "$homelabip" -o eth0 -j MASQUERADE

echo "Done with setup - Test connection"
