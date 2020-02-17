# WireGuard Reverse Proxy Server
Ansible setup to build a WireGuard reverse proxy server that will allow any machine to reach the client by forwarding packets over the VPN network.

## Use Cases
- One static IP to reach you, no matter where you are
- Accept incoming connections through firewalls
- Painless reverse shells in [CTF](https://ctf101.org/) competitions

## Usage
Edit [inventory.ini](inventory.ini) with your desired setup:
- `ctf_wg_port` - The port WireGuard will listen on
- `ctf_reverse_ports` - The ports that will be forwarded to the client

Then, execute the playbook:
```bash
./setup-proxy.sh
```
The WireGuard client profile will be saved under `wg-client.conf`.