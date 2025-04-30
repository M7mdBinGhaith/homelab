# UDP Port Forwarding: EC2 to HomeLab

Automates UDP port forwarding between AWS EC2 and HomeLab using Tailscale. Enables:
- Game servers behind NAT
- UDP-based services in HomeLab
- Remote access to HomeLab services

## Architecture
- VPS Side: AWS EC2 Linux instance
- HomeLab Side: pfSense router
- Connection: Tailscale VPN

## Prerequisites

- AWS EC2 instance
- Tailscale installed on EC2
- `iptables` package on EC2
- `netfilter-persistent` for saving rules

## Usage

### Add Port Forwarding
On EC2 instance:
```bash
sudo ./setup-forwarding.sh
```

Follow the prompts to:
1. Enter EC2 public interface (typically eth0)
2. Enter Tailscale interface (tailscale0)
3. Enter HomeLab server IP
4. Specify ports to forward
5. Type 'd' when finished

### Remove Port Forwarding
On EC2 instance:
```bash
sudo ./remove-forwarding.sh
```

Follow the same prompts to remove forwarding rules.

## Important Notes

- Verify interface names with `ip a`
- FORWARD chain rules are essential
- Rules persist after reboot
- Ensure pfSense firewall allows forwarded ports

## Troubleshooting

1. Verify iptables:
```bash
sudo iptables -L -v -n
sudo iptables -t nat -L -v -n
```

2. Common issues:
- Missing FORWARD rules
- Incorrect interface names
- EC2 security group blocks
- pfSense firewall rules
- Tailscale connection status

## Security Considerations

- Only forward required ports
- Monitor forwarded traffic
- Audit rules regularly
- Keep EC2 and pfSense updated
