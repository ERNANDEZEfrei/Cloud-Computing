# TP1 : Azure first steps

## I. Prérequis
### A. Choix de l'algorithme de chiffrement
**Pourquoi ne pas utiliser RSA :**
https://www.veritas.com/fr/ca/information-center/rsa-encryption


**Quel algo utiliser :**
https://cyber.gouv.fr/sites/default/files/2014/01/NT_OpenSSH.pdf

### B. Génération de votre paire de clés
```
PS C:\Users\TERRA> ssh-keygen -t ecdsa -b 256
Generating public/private ecdsa key pair.
Enter file in which to save the key (C:\Users\TERRA/.ssh/id_ecdsa): cloud_tp1
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
Your identification has been saved in cloud_tp1
Your public key has been saved in cloud_tp1.pub
The key fingerprint is:
SHA256:E5bydA0dSlAuQrRccVRJ85RmFdV42TiSNFLSAHJv5kE alexandre@PC-ALEX-TERRA
The key's randomart image is:
+---[ECDSA 256]---+
|     .+ **EOO+.*O|
|     o = B **=B.+|
|      = * O .+.o |
|       * B .     |
|        S .      |
|         .       |
|                 |
|                 |
|                 |
+----[SHA256]-----+
```
### C. Agent SSH
Activation de OpenSSH :
```powershell
Get-WindowsCapability -Online | Where-Object Name -like 'OpenSSH*'
Add-WindowsCapability -Online -Name OpenSSH.Client~~~~0.0.1.0
```

Ajout de la clé ssh au client : 
```powershell
Get-Service ssh-agent | Set-Service -StartupType Automatic
Start-Service ssh-agent
Get-Service ssh-agent
ssh-add $env:USERPROFILE\.ssh\cloud_tp1
```

## II. Spawn des VMs

### 1. Depuis la WebUI

```bash
ssh azureuser@4.233.103.219
Welcome to Ubuntu 22.04.5 LTS (GNU/Linux 6.8.0-1031-azure x86_64)
``` 

### 2. *az* : a programmatic approach
**Créez une VM depuis le Azure CLI**
```powershell
az vm create -g TP1.2 -n VMTP1.2 --image Ubuntu2204 --admin-username azureuser --ssh-key-values C:\Users\TERRA\.ssh\cloud_tp1.pub --size Standard_B1s --location francecentral
```
**Connection à la VM en SSH sur son IP publique**
```bash
azureuser@VMTP1Terraform:~$ systemctl status walinuxagent.service
Warning: The unit file, source configuration file or drop-ins of walinuxagent.service changed on disk. Run 'systemctl daemon-reload' to reload units.
● walinuxagent.service - Azure Linux Agent
     Loaded: loaded (/lib/systemd/system/walinuxagent.service; enabled; vendor preset: enabled)
    Drop-In: /run/systemd/system.control/walinuxagent.service.d
             └─50-CPUAccounting.conf, 50-MemoryAccounting.conf, 50-CPUQuota.conf
     Active: active (running) since Fri 2025-09-05 14:47:11 UTC; 3min 0s ago
   Main PID: 732 (python3)
      Tasks: 7 (limit: 1063)
     Memory: 41.8M
        CPU: 803ms
     CGroup: /system.slice/walinuxagent.service
             ├─ 732 /usr/bin/python3 -u /usr/sbin/waagent -daemon
             └─1049 python3 -u bin/WALinuxAgent-2.14.0.1-py3.12.egg -run-exthandlers

Sep 05 14:47:21 VMTP1Terraform python3[1049]: 2025-09-05T14:47:21.988329Z INFO EnvHandler ExtHandler The firewall was setup successfully:
Sep 05 14:47:21 VMTP1Terraform python3[1049]: Chain INPUT (policy ACCEPT 0 packets, 0 bytes)
Sep 05 14:47:21 VMTP1Terraform python3[1049]:     pkts      bytes target     prot opt in     out     source               destination
Sep 05 14:47:21 VMTP1Terraform python3[1049]: Chain FORWARD (policy ACCEPT 0 packets, 0 bytes)
Sep 05 14:47:21 VMTP1Terraform python3[1049]:     pkts      bytes target     prot opt in     out     source               destination
Sep 05 14:47:21 VMTP1Terraform python3[1049]: Chain OUTPUT (policy ACCEPT 0 packets, 0 bytes)
Sep 05 14:47:21 VMTP1Terraform python3[1049]:     pkts      bytes target     prot opt in     out     source               destination
Sep 05 14:47:21 VMTP1Terraform python3[1049]:        0        0 ACCEPT     tcp  --  *      *       0.0.0.0/0            168.63.129.16        tcp dpt:53
Sep 05 14:47:21 VMTP1Terraform python3[1049]:        0        0 ACCEPT     tcp  --  *      *       0.0.0.0/0            168.63.129.16        owner UID match 0
Sep 05 14:47:21 VMTP1Terraform python3[1049]:        0        0 DROP       tcp  --  *      *       0.0.0.0/0            168.63.129.16        ctstate INVALID,NEW
```
**Vérification service**
```bash
azureuser@VMTP1Terraform:~$ systemctl status cloud-init.service
● cloud-init.service - Cloud-init: Network Stage
     Loaded: loaded (/lib/systemd/system/cloud-init.service; enabled; vendor preset: enabled)
     Active: active (exited) since Fri 2025-09-05 14:47:10 UTC; 4min 55s ago
   Main PID: 524 (code=exited, status=0/SUCCESS)
      Tasks: 0 (limit: 1063)
     Memory: 0B
     CGroup: /system.slice/cloud-init.service

Sep 05 14:47:10 VMTP1Terraform cloud-init[529]: |  o=+o..   + .   |
Sep 05 14:47:10 VMTP1Terraform cloud-init[529]: |  ..* .   + B .  |
Sep 05 14:47:10 VMTP1Terraform cloud-init[529]: | o . = .   O +   |
Sep 05 14:47:10 VMTP1Terraform cloud-init[529]: |o   . B S o + .  |
Sep 05 14:47:10 VMTP1Terraform cloud-init[529]: | o     B o . .   |
Sep 05 14:47:10 VMTP1Terraform cloud-init[529]: |  o   . . o .    |
Sep 05 14:47:10 VMTP1Terraform cloud-init[529]: | ..  . o . .     |
Sep 05 14:47:10 VMTP1Terraform cloud-init[529]: |  .o. o++        |
Sep 05 14:47:10 VMTP1Terraform cloud-init[529]: +----[SHA256]-----+
Sep 05 14:47:10 VMTP1Terraform systemd[1]: Finished Cloud-init: Network Stage.
```

### 3. Terraforming planets infrastructures
```powershell
PS G:\Mon Drive\Cours\EFREI\Cloud-Computing\TP1> terraform apply

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # azurerm_linux_virtual_machine.main will be created
  + resource "azurerm_linux_virtual_machine" "main" {
      + admin_username                                         = "*********"
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
      + resource_group_name                                    = "TP1Terraform"
      + size                                                   = "Standard_B1s"
      + virtual_machine_id                                     = (known after apply)
      + vm_agent_platform_updates_enabled                      = (known after apply)

      + admin_ssh_key {
          + public_key = <<-EOT
                ssh-ed25519 ********************/************************ **********@**************
            EOT
          + username   = "*********"
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
        ```