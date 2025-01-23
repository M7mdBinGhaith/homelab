#!/bin/bash
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run with sudo or as the root user."
    exit 1
fi
remove_iptables_rules() {
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
        read -p "Enter the port number to remove (or type 'd' to finish): " port
        if [[ "$port" = "d" ]]; then
            echo "Exiting. iptables rules have been removed for all entered port                                                                                                             s."
            break
        fi
        if ! [[ "$port" =~ ^[0-9]+$ ]]; then
            echo "Error: Port number must be an integer."
            continue
        fi
        echo "Removing iptables rules for port $port..."
        # Remove DNAT rule for incoming traffic
        iptables -t nat -D PREROUTING -i ens5 -p udp --dport $port -j DNAT --to-                                                                                                             destination $TARGET_IP
        # Remove SNAT rule for outgoing traffic
        iptables -t nat -D POSTROUTING -o tailscale0 -p udp --dport $port -d $TA                                                                                                             RGET_IP -j SNAT --to-source $TAILSCALE_IP
        # Remove forward rules for bidirectional traffic
        iptables -D FORWARD -i ens5 -o tailscale0 -p udp -d $TARGET_IP --dport $                                                                                                             port -j ACCEPT
        iptables -D FORWARD -i tailscale0 -o ens5 -p udp -s $TARGET_IP --sport $                                                                                                             port -j ACCEPT
        echo "iptables rules removed for port $port."
    done
    # Save rules
    if command -v netfilter-persistent &> /dev/null; then
        netfilter-persistent save
    fi
    echo "All requested iptables rules have been removed and saved."
}
remove_iptables_rules


Let me 
