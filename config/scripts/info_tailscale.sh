#!/bin/sh

status=$(curl --silent --fail --unix-socket /var/run/tailscale/tailscaled.sock http://local-tailscaled.sock/localapi/v0/status)

# bail out if curl had non-zero exit code
if [ $? != 0 ]; then
    exit 0
fi

# check if it's stopped (down)
if [ "$(echo ${status} | jq --raw-output .BackendState)" = "Stopped" ]; then
    echo "VPN down"
    exit 0
fi

# if an exit node is active, show its hostname
exit_node_hostname="$(echo ${status} | jq --raw-output '.Peer[] | select(.ExitNode) | .HostName')"
if [ -n "${exit_node_hostname}" ]; then
    echo "$VPN ${exit_node_hostname}"
else
    echo "VPN up"
fi
