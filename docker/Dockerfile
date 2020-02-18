#
# Requires WireGuard kernel module installed in host
#

FROM alpine:latest
LABEL Name=local/wg-server

RUN apk --no-cache add wireguard-tools

COPY wg-server.conf /etc/wireguard/
COPY start.sh /
RUN chmod +x /start.sh

ENTRYPOINT ["/start.sh"]
EXPOSE {{ ctf_wg_port }}
