# WireGuard Reverse Proxy Server
[Ansible](https://www.ansible.com/) setup to build a [WireGuard](https://www.wireguard.com/)-powered [reverse proxy](https://www.cloudflare.com/learning/cdn/glossary/reverse-proxy/) server that will allow any machine to reach the client by forwarding packets over the [VPN](https://en.wikipedia.org/wiki/Virtual_private_network) network.

## Use Cases
- The same static IP to reach you, no matter where you are
- Accept incoming connections through any firewall
- Painless reverse shells in [CTF](https://ctf101.org/) competitions

## Usage
Edit [inventory.ini](inventory.ini) with your desired setup:
- `ctf_wg_port` 
  - The port WireGuard will listen on
- `ctf_reverse_ports`
  - The ports that will be forwarded to the client
  - Parsed by `iptables` rule: `-m multiport --dports <ctf_reverse_ports>`
- `ctf_client_ip`
  - The VPN client IP
- `ctf_server_ip` 
  - The VPN server IP
- `ctf_subnet` 
  - The VPN subnet
- `ctf_keep_existing_profile`
  - Whether to keep existing WireGuard profile if one exists

If you want to use your own keys, add them to the `ctf_*_*key` variables.
Otherwise, leave them empty and the Ansible script will generate new ones for you.

Then, execute the playbook:
```bash
./setup-proxy.sh
```
The WireGuard client profile will be saved under `wg-client.conf`.
