# TP2 : Aller plus loing aveceuh Azure
## I. Network Security Group
### 1. Ptite intro
### 2. Ajouter un NSG au déploiement
[Voir dans le ficher 'network.tf'](network.tf)
### 3. Proofs !
Preuve du fonctionnement du ```terraform apply``` :
```powershell
PS G:\Mon Drive\Cours\EFREI\Cloud-Computing\TP2> terraform apply

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # azurerm_linux_virtual_machine.main will be created
  + resource "azurerm_linux_virtual_machine" "main" {
      + admin_username                                         = "azureuser"
      + allow_extension_operations                             = (known after apply)
      + bypass_platform_safety_checks_on_user_schedule_enabled = false
      + computer_name                                          = (known after apply)
      + disable_password_authentication                        = (known after apply)
      + disk_controller_type                                   = (known after apply)
      + extensions_time_budget                                 = "PT1H30M"
      + id                                                     = (known after apply)
      + location                                               = "francecentral"
      + max_bid_price                                          = -1
      + name                                                   = "VMTP1Terraform"
      + network_interface_ids                                  = (known after apply)
      + os_managed_disk_id                                     = (known after apply)
      + patch_assessment_mode                                  = (known after apply)
      + patch_mode                                             = (known after apply)
      + platform_fault_domain                                  = -1
      + priority                                               = "Regular"
      + private_ip_address                                     = (known after apply)
      + private_ip_addresses                                   = (known after apply)
      + provision_vm_agent                                     = (known after apply)
      + public_ip_address                                      = (known after apply)
      + public_ip_addresses                                    = (known after apply)
      + resource_group_name                                    = "TP2Terraform"
      + size                                                   = "Standard_B1s"
      + virtual_machine_id                                     = (known after apply)
      + vm_agent_platform_updates_enabled                      = (known after apply)

      + admin_ssh_key {
          + public_key = <<-EOT
                ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMpryc/bbjDYXis2x38dcWKhb0WT9ANfwIeiMyxxw7iK alexandre@PC-ALEX-TERRA
            EOT
          + username   = "azureuser"
        }

      + os_disk {
          + caching                   = "ReadWrite"
          + disk_size_gb              = (known after apply)
          + id                        = (known after apply)
          + name                      = "vm-os-disk"
          + storage_account_type      = "Standard_LRS"
          + write_accelerator_enabled = false
        }

      + source_image_reference {
          + offer     = "0001-com-ubuntu-server-focal"
          + publisher = "Canonical"
          + sku       = "20_04-lts"
          + version   = "latest"
        }

      + termination_notification (known after apply)
    }

  # azurerm_network_interface.main will be created
  + resource "azurerm_network_interface" "main" {
      + accelerated_networking_enabled = false
      + applied_dns_servers            = (known after apply)
      + id                             = (known after apply)
      + internal_domain_name_suffix    = (known after apply)
      + ip_forwarding_enabled          = false
      + location                       = "francecentral"
      + mac_address                    = (known after apply)
      + name                           = "vm-nic"
      + private_ip_address             = (known after apply)
      + private_ip_addresses           = (known after apply)
      + resource_group_name            = "TP2Terraform"
      + virtual_machine_id             = (known after apply)

      + ip_configuration {
          + gateway_load_balancer_frontend_ip_configuration_id = (known after apply)
          + name                                               = "internal"
          + primary                                            = (known after apply)
          + private_ip_address                                 = (known after apply)
          + private_ip_address_allocation                      = "Dynamic"
          + private_ip_address_version                         = "IPv4"
          + public_ip_address_id                               = (known after apply)
          + subnet_id                                          = (known after apply)
        }
    }

  # azurerm_network_interface_security_group_association.main will be created
  + resource "azurerm_network_interface_security_group_association" "main" {
      + id                        = (known after apply)
      + network_interface_id      = (known after apply)
      + network_security_group_id = (known after apply)
    }

  # azurerm_network_security_group.main will be created
  + resource "azurerm_network_security_group" "main" {
      + id                  = (known after apply)
      + location            = "francecentral"
      + name                = "VMTP2Terraform-nsg"
      + resource_group_name = "TP2Terraform"
      + security_rule       = [
          + {
              + access                                     = "Allow"
              + destination_address_prefix                 = "*"
              + destination_address_prefixes               = []
              + destination_application_security_group_ids = []
              + destination_port_range                     = "22"
              + destination_port_ranges                    = []
              + direction                                  = "Inbound"
              + name                                       = "Allow_SSH"
              + priority                                   = 1001
              + protocol                                   = "Tcp"
              + source_address_prefix                      = "83.192.233.164/32"
              + source_address_prefixes                    = []
              + source_application_security_group_ids      = []
              + source_port_range                          = "*"
              + source_port_ranges                         = []
                # (1 unchanged attribute hidden)
            },
        ]
    }

  # azurerm_public_ip.main will be created
  + resource "azurerm_public_ip" "main" {
      + allocation_method       = "Static"
      + ddos_protection_mode    = "VirtualNetworkInherited"
      + fqdn                    = (known after apply)
      + id                      = (known after apply)
      + idle_timeout_in_minutes = 4
      + ip_address              = (known after apply)
      + ip_version              = "IPv4"
      + location                = "francecentral"
      + name                    = "vm-ip"
      + resource_group_name     = "TP2Terraform"
      + sku                     = "Standard"
      + sku_tier                = "Regional"
    }

  # azurerm_resource_group.main will be created
  + resource "azurerm_resource_group" "main" {
      + id       = (known after apply)
      + location = "francecentral"
      + name     = "TP2Terraform"
    }

  # azurerm_subnet.main will be created
  + resource "azurerm_subnet" "main" {
      + address_prefixes                              = [
          + "10.0.1.0/24",
        ]
      + default_outbound_access_enabled               = true
      + id                                            = (known after apply)
      + name                                          = "vm-subnet"
      + private_endpoint_network_policies             = "Disabled"
      + private_link_service_network_policies_enabled = true
      + resource_group_name                           = "TP2Terraform"
      + virtual_network_name                          = "vm-vnet"
    }

  # azurerm_virtual_network.main will be created
  + resource "azurerm_virtual_network" "main" {
      + address_space                  = [
          + "10.0.0.0/16",
        ]
      + dns_servers                    = (known after apply)
      + guid                           = (known after apply)
      + id                             = (known after apply)
      + location                       = "francecentral"
      + name                           = "vm-vnet"
      + private_endpoint_vnet_policies = "Disabled"
      + resource_group_name            = "TP2Terraform"
      + subnet                         = (known after apply)
    }

Plan: 8 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value:
```
Preuve du *nsg* via une commande *az* : 
```powershell
az >> az network nic show --ids /subscriptions/***********************/resourceGroups/TP2Terraform/providers/Microsoft.Network/networkInt
option '--subscription' will be ignored due to use of '--ids'.
option '-n' will be ignored due to use of '--ids'.
option '--resource-group' will be ignored due to use of '--ids'.
{
  "auxiliaryMode": "None",
  "auxiliarySku": "None",
  "disableTcpStateTracking": false,
  "dnsSettings": {
    "appliedDnsServers": [],
    "dnsServers": [],
    "internalDomainNameSuffix": "xzzn5d4ui1nezhcjd55iqkroxa.parx.internal.cloudapp.net"
  },
  "enableAcceleratedNetworking": false,
  "enableIPForwarding": false,
  "etag": "W/\"77d7a931-26e6-4f3c-b17c-137f554b9fdb\"",
  "hostedWorkloads": [],
  "id": "/subscriptions/1ac3cb02-c5db-4603-97cd-24523ae7a6d3/resourceGroups/TP2Terraform/providers/Microsoft.Network/networkInterfaces/vm-nic",
  "ipConfigurations": [
    {
      "etag": "W/\"77d7a931-26e6-4f3c-b17c-137f554b9fdb\"",
      "id": "/subscriptions/**********************/resourceGroups/TP2Terraform/providers/Microsoft.Network/networkInterfaces/vm-nic/ipConfigurations/internal",
      "name": "internal",
      "primary": true,
      "privateIPAddress": "10.0.1.4",
      "privateIPAddressVersion": "IPv4",
      "privateIPAllocationMethod": "Dynamic",
      "provisioningState": "Succeeded",
      "publicIPAddress": {
        "id": "/subscriptions/**********************/resourceGroups/TP2Terraform/providers/Microsoft.Network/publicIPAddresses/vm-ip",
        "resourceGroup": "TP2Terraform"
      },
      "resourceGroup": "TP2Terraform",
      "subnet": {
        "id": "/subscriptions/**********************/resourceGroups/TP2Terraform/providers/Microsoft.Network/virtualNetworks/vm-vnet/subnets/vm-subnet",
        "resourceGroup": "TP2Terraform"
      },
      "type": "Microsoft.Network/networkInterfaces/ipConfigurations"
    }
  ],
  "location": "francecentral",
  "macAddress": "00-22-48-39-E8-BC",
  "name": "vm-nic",
  "networkSecurityGroup": {
    "id": "/subscriptions/************************/resourceGroups/TP2Terraform/providers/Microsoft.Network/networkSecurityGroups/VMTP2Terraform-nsg",
    "resourceGroup": "TP2Terraform"
  },
  "nicType": "Standard",
  "primary": true,
  "provisioningState": "Succeeded",
  "resourceGroup": "TP2Terraform",
  "resourceGuid": "************************",
  "tags": {},
  "tapConfigurations": [],
  "type": "Microsoft.Network/networkInterfaces",
  "virtualMachine": {
    "id": "/subscriptions/************************/resourceGroups/TP2Terraform/providers/Microsoft.Compute/virtualMachines/VMTP2Terraform",
    "resourceGroup": "TP2Terraform"
  },
  "vnetEncryptionSupported": false
}
```
Preuve de la connection ssh : 
```powershell
PS C:\Users\TERRA> ssh azureuser@52.143.170.186
The authenticity of host '52.143.170.186 (52.143.170.186)' can't be established.
ED25519 key fingerprint is SHA256:jLjylrfghd4hopBe+S3pPRFaxxlYU5f4MTOR4VM0rNs.
This key is not known by any other names.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added '52.143.170.186' (ED25519) to the list of known hosts.
Welcome to Ubuntu 20.04.6 LTS (GNU/Linux 5.15.0-1089-azure x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/pro

 System information as of Wed Sep 10 15:29:31 UTC 2025

  System load:  0.0               Processes:             111
  Usage of /:   5.3% of 28.89GB   Users logged in:       0
  Memory usage: 30%               IPv4 address for eth0: 10.0.1.4
  Swap usage:   0%

Expanded Security Maintenance for Applications is not enabled.

0 updates can be applied immediately.

Enable ESM Apps to receive additional future security updates.
See https://ubuntu.com/esm or run: sudo pro status


The list of available updates is more than a week old.
To check for new updates run: sudo apt update


The programs included with the Ubuntu system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Ubuntu comes with ABSOLUTELY NO WARRANTY, to the extent permitted by
applicable law.

To run a command as administrator (user "root"), use "sudo <command>".
See "man sudo_root" for details.

azureuser@VMTP2Terraform:~$
```
**Étape pour l'écoute sur le port 2222 :**

Modification du port d'écoute :
```
azureuser@VMTP2Terraform:~$ sudo nano /etc/ssh/sshd_config
#       $OpenBSD: sshd_config,v 1.103 2018/04/09 20:41:22 tj Exp $

# This is the sshd server system-wide configuration file.  See
# sshd_config(5) for more information.

# This sshd was compiled with PATH=/usr/bin:/bin:/usr/sbin:/sbin

# The strategy used for options in the default sshd_config shipped with
# OpenSSH is to specify options with their default value where
# possible, but leave them commented.  Uncommented options override the
# default value.

Include /etc/ssh/sshd_config.d/*.conf

Port 2222
#AddressFamily any
#ListenAddress 0.0.0.0
#ListenAddress ::
```
Puis redemarrage du service : 
```bash
sudo systemctl restart sshd
```
Vérification de l'ecoute du port :
```bash
azureuser@VMTP2Terraform:~$ sudo ss -tulpn | grep sshd
tcp     LISTEN   0        128              0.0.0.0:2222          0.0.0.0:*       users:(("sshd",pid=1938,fd=3))         
tcp     LISTEN   0        128                 [::]:2222             [::]:*       users:(("sshd",pid=1938,fd=4)) 
```
Test de connection :
``` powershell
PS C:\Users\TERRA> ssh -p 2222 azureuser@52.143.170.186
ssh: connect to host 52.143.170.186 port 2222: Connection timed out
```

## II. Un ptit nom DNS
### 1. Adapter le plan Terraform
[Voir dans le ficher 'main.tf'](main.tf)
### 2. Ajouter un output custom à terraform apply
[Voir dans le ficher 'outputs.tf'](outputs.tf)
### 3. Proooofs !
Voici la sortie de la commande fonctionnel ```terraform apply``` :
```powershell
PS G:\Mon Drive\Cours\EFREI\Cloud-Computing\TP2> terraform apply
azurerm_resource_group.main: Refreshing state... [id=/subscriptions/1ac3cb02-c5db-4603-97cd-24523ae7a6d3/resourceGroups/TP2Terraform]
azurerm_network_security_group.main: Refreshing state... [id=/subscriptions/1ac3cb02-c5db-4603-97cd-24523ae7a6d3/resourceGroups/TP2Terraform/providers/Microsoft.Network/networkSecurityGroups/VMTP2Terraform-nsg]
azurerm_public_ip.main: Refreshing state... [id=/subscriptions/1ac3cb02-c5db-4603-97cd-24523ae7a6d3/resourceGroups/TP2Terraform/providers/Microsoft.Network/publicIPAddresses/vm-ip]
azurerm_virtual_network.main: Refreshing state... [id=/subscriptions/1ac3cb02-c5db-4603-97cd-24523ae7a6d3/resourceGroups/TP2Terraform/providers/Microsoft.Network/virtualNetworks/vm-vnet]
azurerm_subnet.main: Refreshing state... [id=/subscriptions/1ac3cb02-c5db-4603-97cd-24523ae7a6d3/resourceGroups/TP2Terraform/providers/Microsoft.Network/virtualNetworks/vm-vnet/subnets/vm-subnet]
azurerm_network_interface.main: Refreshing state... [id=/subscriptions/1ac3cb02-c5db-4603-97cd-24523ae7a6d3/resourceGroups/TP2Terraform/providers/Microsoft.Network/networkInterfaces/vm-nic]
azurerm_linux_virtual_machine.main: Refreshing state... [id=/subscriptions/1ac3cb02-c5db-4603-97cd-24523ae7a6d3/resourceGroups/TP2Terraform/providers/Microsoft.Compute/virtualMachines/VMTP2Terraform]

Changes to Outputs:
  + vm_dns_name  = "vmtp2terraform.francecentral.cloudapp.azure.com"
  + vm_public_ip = "52.143.170.186"

You can apply this plan to save these new output values to the Terraform state, without changing any real infrastructure.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes


Apply complete! Resources: 0 added, 0 changed, 0 destroyed.

Outputs:

vm_dns_name = "vmtp2terraform.francecentral.cloudapp.azure.com"
vm_public_ip = "52.143.170.186"
```
Connection à la VM via son nom de domain :
```powershell
PS C:\Users\TERRA> ssh azureuser@vmtp2terraform.francecentral.cloudapp.azure.com
The authenticity of host 'vmtp2terraform.francecentral.cloudapp.azure.com (52.143.170.186)' can't be established.
ED25519 key fingerprint is SHA256:jLjylrfghd4hopBe+S3pPRFaxxlYU5f4MTOR4VM0rNs.
This host key is known by the following other names/addresses:
    C:\Users\TERRA/.ssh/known_hosts:24: 52.143.170.186
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added 'vmtp2terraform.francecentral.cloudapp.azure.com' (ED25519) to the list of known hosts.
Welcome to Ubuntu 20.04.6 LTS (GNU/Linux 5.15.0-1089-azure x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/pro

 System information as of Wed Sep 10 16:35:53 UTC 2025

  System load:  0.0               Processes:             110
  Usage of /:   5.5% of 28.89GB   Users logged in:       0
  Memory usage: 31%               IPv4 address for eth0: 10.0.1.4
  Swap usage:   0%


Expanded Security Maintenance for Applications is not enabled.

0 updates can be applied immediately.

Enable ESM Apps to receive additional future security updates.
See https://ubuntu.com/esm or run: sudo pro status


The list of available updates is more than a week old.
To check for new updates run: sudo apt update
New release '22.04.5 LTS' available.
Run 'do-release-upgrade' to upgrade to it.


Last login: Wed Sep 10 15:29:33 2025 from 83.192.233.164
azureuser@VMTP2Terraform:~$
```
## III. Blob storage
### 2. Let's g
[Voir dans le ficher 'storage.tf'](storage.tf)
###
```bash
azureuser@VMTP2Terraform:~$ azcopy login
INFO: Authentication is required. To sign in, open the webpage https://microsoft.com/devicelogin and enter the code C63MF5Y6M to authenticate.
INFO: Logging in under the "Common" tenant. This will log the account in under its home tenant.
INFO: If you plan to use AzCopy with a B2B account (where the account's home tenant is separate from the tenant of the target storage account), please sign in under the target tenant with --tenant-id
INFO: Login succeeded.
```