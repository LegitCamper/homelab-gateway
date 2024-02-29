# My homelab gateway script

## Motives 
I have seen quite a few ways to deal with homelab issues like port forwarding and changing resedential ip's. Most of the solutions I found were either hard to configure or limited the types of data I could forward.

## Why not cloudflare tunnels
When I first created my homelab this was a simple setup and allowed me to use https certs and add new services with ease. I quickly out grew cloudflare tunnels. They only allowed forwarding port 80 and 443 so hosting Minecraft server's behind it was not an option
  
## Solution
I have simply chosen to use Tailscale on my homelab and my proxy server. This simplifies all the networking for me so I can just point any domain at my proxy's static ip and it will be forwarded to my homelab with iptables. The script points all inbound ports to my tailscale ip. This unfortunatly includes ssh, but with tailscale they have a solution for that `tailscale ssh machine-name`. I then have a [reverse proxy](https://github.com/LegitCamper/homelab/blob/ad12135e0f30c7f3194ccb065a0033e50614d0c4/network.yml#L30) running on my homelab to handle all the complex stuff

## Requirements
Just need a tailscale account which is free and copy a api key in `/root/tailscaleapikey.txt` and then run the script.
