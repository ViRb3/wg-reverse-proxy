#!/bin/sh
set -e

function setup_iptables() {
   echo "Applying iptable rules..."
   # allow WireGuard traffic
   iptables -t filter $1 INPUT -p tcp --dport {{ ctf_wg_port }} -j ACCEPT
   iptables -t filter $1 INPUT -p udp --dport {{ ctf_wg_port }} -j ACCEPT
   # allow to-be-forwarded traffic
   iptables -t filter $1 INPUT -p tcp -m multiport --dports {{ ctf_reverse_ports | join(',') }} -j ACCEPT
   iptables -t filter $1 INPUT -p udp -m multiport --dports {{ ctf_reverse_ports | join(',') }} -j ACCEPT
   # forward the to-be-forwarded traffic
   iptables -t nat $1 PREROUTING -p tcp -m conntrack --ctstate NEW -m multiport --dports {{ ctf_reverse_ports | join(',') }} -j DNAT --to-destination 10.8.0.100
   iptables -t nat $1 PREROUTING -p udp -m conntrack --ctstate NEW -m multiport --dports {{ ctf_reverse_ports | join(',') }} -j DNAT --to-destination 10.8.0.100
   # ensure forwarding
   iptables $1 FORWARD -o wg-server -j ACCEPT
   iptables $1 FORWARD -i wg-server -j ACCEPT
   # ensure all connections happen through this server, not directly
   iptables -t nat $1 POSTROUTING -d 10.8.0.0/24 -j MASQUERADE
   echo "Done applying iptable rules"
}

function cleanup() {
    set +e
    echo "Container stopped, performing cleanup..."
    wg-quick down wg-server
    setup_iptables "-D"
    echo "Done performing cleanup"
    set -e
}

# trap first to be able to recover from error
trap cleanup SIGHUP SIGINT SIGQUIT SIGABRT SIGTERM EXIT

wg-quick up wg-server
setup_iptables "-A"

# sleep forever, still catching signal
while :
do
   sleep 2073600 &
   wait $!
done
