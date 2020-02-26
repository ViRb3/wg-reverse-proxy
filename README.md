# WireGuard Reverse Proxy Server
[Ansible](https://www.ansible.com/) setup to build a [WireGuard](https://www.wireguard.com/)-powered [reverse proxy](https://www.cloudflare.com/learning/cdn/glossary/reverse-proxy/) server that will allow any machine to reach the client by forwarding packets over the [VPN](https://en.wikipedia.org/wiki/Virtual_private_network) network.

## Use Cases
- The same static IP to reach you, no matter where you are
- Accept incoming connections through any firewall
- Painless reverse shells in [CTF](https://ctf101.org/) competitions

## Usage
Edit [inventory.ini](inventory.ini) with your desired setup.

Then, execute the playbook:
```bash
./setup-proxy.sh
```

The WireGuard client profile will be saved under `wg-client.conf`.
