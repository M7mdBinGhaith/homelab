#!/bin/bash
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run with sudo or as the root user."
    exit 1
fi

apply_iptables_rules() {
    TAILSCALE_IP=$(tailscale ip -4)
    if [[ -z "$TAILSCALE_IP" ]]; then
        echo "Error: Could not get Tailscale IP. Is Tailscale running?"
        exit 1
    fi

    read -p "Enter the internal IP of the target server: " TARGET_IP
    if ! [[ $TARGET_IP =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
        echo "Error: Invalid IP address format"
        exit 1
    fi

    while true; do
        read -p "Enter the port number (or type 'd' to finish): " port
        if [[ "$port" = "d" ]]; then
            echo "Exiting. iptables rules have been applied for all entered ports."
            break
        fi

        if ! [[ "$port" =~ ^[0-9]+$ ]]; then
            echo "Error: Port number must be an integer."
            continue
        fi

        echo "Applying iptables rules for port $port..."
        
        # DNAT rule for incoming traffic
        iptables -t nat -A PREROUTING -i ens5 -p udp --dport $port -j DNAT --to-destination $TARGET_IP
        
        # SNAT rule for outgoing traffic
        iptables -t nat -A POSTROUTING -o tailscale0 -p udp --dport $port -d $TARGET_IP -j SNAT --to-source $TAILSCALE_IP
        
        # Forward rules for bidirectional traffic
        iptables -A FORWARD -i ens5 -o tailscale0 -p udp -d $TARGET_IP --dport $port -j ACCEPT
        iptables -A FORWARD -i tailscale0 -o ens5 -p udp -s $TARGET_IP --sport $port -j ACCEPT

        echo "iptables rules applied for port $port."
    done

    # Save rules
    if command -v netfilter-persistent &> /dev/null; then
        netfilter-persistent save
    fi

    echo "All requested iptables rules have been applied and saved."
}

apply_iptables_rules
