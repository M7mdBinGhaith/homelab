# Infrastructure as Code (IaC)

This directory contains Infrastructure as Code configurations for the homelab environment.

## Overview


1. **[Packer](./packer/)** builds VM templates in Proxmox
2. **[Terraform](./terraform/)** provisions VMs from these templates  
3. **[Ansible](./ansible/)** deploys services and maintains systems

## Workflow

### 1. Template Creation (Packer)
- Creates standardized Debian 12 VM templates in Proxmox
- Includes cloud-init and qemu-guest-agent
- Templates serve as the foundation for all VMs

### 2. Infrastructure Provisioning (Terraform)
- Clones VMs from the template built with packer
- Configures VM resources (CPU, memory, storage, network)
- Sets up initial cloud init configuration

### 3. Deployment of services & System maintenance (Ansible)
- Installs and configures software
- Handles ongoing system maintenance and updates

## Usage

Execute in sequential order:
1. Build templates with Packer
2. Provision VMs with Terraform  
3. Deploy services with Ansible 

