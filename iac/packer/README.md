# Packer Template

A Packer template for creating Debian virtual machine images in Proxmox VE.

## Execution Context

This template is designed to be executed directly from the command line:

* **Source:** Template is stored in this repository and executed locally.
* **Workflow:** The template defines the build process and configuration for Debian images.
* **Authentication:** Proxmox API credentials are managed through environment variables and configuration files.

## Configuration

The template requires the following environment variables to be set:

* **Proxmox API URL:** Configured in `variables.pkr.hcl`
* **Proxmox API Token:** Configured in `variables.pkr.hcl`
* **Proxmox Node:** Configured in `variables.pkr.hcl`

## Usage

To build the image:

```bash
# Initialize Packer
packer init .

# Build the image
packer build .
``` 