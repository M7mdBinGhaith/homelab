# Ansible Playbooks

Collection of Ansible playbooks for infrastructure automation and service deployment.

## Structure

- **[common/](./common/)** - Shared tasks and utilities
- **[deploy/](./deploy/)** - Infrastructure deployment playbooks  
- **[install/](./install/)** - Service installation playbooks
- **[maintain/](./maintain/)** - System maintenance tasks
- **[files/](./files/)** - Configuration files and templates

## Execution

Playbook execution have been tested with:
- Automation platforms (Semaphore, Kestra)
- Command line with `ansible-playbook`
